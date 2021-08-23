import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/http_client/http_client.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Handler {
  final UnauthHttpClient _unauthHttpClient = getIt<UnauthHttpClient>();

  Future<Failure?> checkConnectivity() async {
    if (!(await _unauthHttpClient.isConnected())) {
      return const Failure(status: FailureStatus.NoConn);
    }

    final hasServerConnection = await this.hasServerConnection();
    if (!hasServerConnection) {
      return const Failure(status: FailureStatus.ServersDown);
    }
  }

  Future<bool> hasServerConnection() async {
    try {
      await _unauthHttpClient.getReq('/ping');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Failure> basicGqlErrorHandler(OperationResponse resp) async {
    final errors = resp.graphqlErrors;

    if (resp.linkException != null) {
      if (resp.linkException!.originalException is Failure) {
        return resp.linkException!.originalException;
      } else if (resp.linkException!.originalException is HttpException) {
        return _unauthHttpClient
            .basicHttpErrorHandler(resp.linkException!.originalException);
      }
    }

    if (errors != null) {
      StringBuffer errorBuff = StringBuffer();
      errors.forEach((error) {
        errorBuff.write(error.message);
      });
      return Failure(
          message: errorBuff.toString(), status: FailureStatus.GQLMisc);
    }

    final disconnectedFailure = await checkConnectivity();

    if (disconnectedFailure != null) {
      return disconnectedFailure;
    }

    return const Failure(status: FailureStatus.Unknown);
  }

  void handleFailure(Failure f, BuildContext context,
      {String? withPrefix, bool toast = true}) {
    if (f.status.fatal) {
      context.read<MainCubit>().logOut(withError: f.message);
    } else {
      String errorString = f.message ?? f.status.message;

      if (withPrefix != null) {
        errorString = withPrefix + ': ' + errorString;
      }

      if (toast) {
        //if we're in a build, wait for the build tocomplete
        //to avoid errors.
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          context.read<ToasterCubit>().add(Toast(
                message: errorString,
                type: ToastType.Error,
              ));
        });
      }
    }
  }
}
