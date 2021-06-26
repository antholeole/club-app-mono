import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class GqlOperation<TData, TVars> extends StatefulWidget {
  final OperationRequest<TData, TVars> operationRequest;
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
  _GqlOperationState<TData, TVars> createState() =>
      _GqlOperationState<TData, TVars>();
}

class _GqlOperationState<TData, TVars>
    extends State<GqlOperation<TData, TVars>> {
  final client = getIt<Client>();
  TData? resultFromCache;

  @override
  void didUpdateWidget(GqlOperation<TData, TVars> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.operationRequest != widget.operationRequest) {
      setState(() => resultFromCache = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Operation(
      operationRequest: widget.operationRequest,
      builder: (BuildContext context, OperationResponse<TData, TVars>? response,
          Object? error) {
        if (response == null || response.loading) {
          return widget.loader ??
              Loader(
                size: 12,
              );
        }

        if (response.hasErrors) {
          basicGqlErrorHandler(response).then((f) =>
              handleFailure(f, context, withPrefix: widget.toastErrorPrefix));
          return resultFromCache != null
              ? widget.onResponse(resultFromCache!)
              : widget.error ??
                  Text(
                    'error',
                    style: TextStyle(color: Colors.red),
                  );
        }

        resultFromCache = response.data;

        return widget.onResponse(response.data!);
      },
      client: client,
    );
  }
}
