import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/cupertino.dart';

import 'failure.dart';
import 'failure_status.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handleFailure(Failure f, BuildContext context,
    {String? withPrefix, bool toast = true}) {
  debugPrint('got failure: ${f.message}');

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
        try {
          context.read<ToasterCubit>().add(Toast(
                message: errorString,
                type: ToastType.Error,
              ));
        } catch (e) {
          print(e);
        }
      });
    }
  }
}
