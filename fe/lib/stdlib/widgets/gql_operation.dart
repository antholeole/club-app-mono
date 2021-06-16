import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class GqlOperation<TData, TVars> extends StatelessWidget {
  final OperationRequest<TData, TVars> operationRequest;
  final client = getIt<Client>();
  final Widget? loader;
  final String? toastErrorPrefix;
  final Widget? error;
  final Widget Function(TData) onResponse;

  GqlOperation(
      {required this.operationRequest,
      required this.onResponse,
      this.loader,
      this.error,
      this.toastErrorPrefix});

  @override
  Widget build(BuildContext context) {
    return Operation(
      operationRequest: operationRequest,
      builder: (BuildContext context, OperationResponse<TData, TVars>? response,
          Object? error) {
        if (response == null || response.loading) {
          return loader ??
              Loader(
                size: 12,
              );
        }

        if (response.hasErrors) {
          basicGqlErrorHandler(response).then(
              (f) => handleFailure(f, context, withPrefix: toastErrorPrefix));
          return this.error ??
              Text(
                'error',
                style: TextStyle(color: Colors.red),
              );
        }

        return onResponse(response.data!);
      },
      client: client,
    );
  }
}
