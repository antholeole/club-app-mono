import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class GqlOperation<TData, TVars> extends StatefulWidget {
  final OperationRequest<TData, TVars>? operationRequest;
  final Widget? loader;
  final String? errorText;
  final Widget? error;
  final Widget Function(TData) onResponse;

  const GqlOperation(
      {this.operationRequest,
      required this.onResponse,
      this.loader,
      this.error,
      this.errorText});

  @override
  _GqlOperationState<TData, TVars> createState() =>
      _GqlOperationState<TData, TVars>();
}

class _GqlOperationState<TData, TVars>
    extends State<GqlOperation<TData, TVars>> {
  final _client = getIt<Client>();
  TData? _resultFromCache;

  @override
  void didUpdateWidget(GqlOperation<TData, TVars> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.operationRequest != widget.operationRequest) {
      setState(() => _resultFromCache = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.operationRequest == null) {
      return _buildLoader();
    }

    return Operation(
      operationRequest: widget.operationRequest!,
      builder: (BuildContext context, OperationResponse<TData, TVars>? response,
          Object? error) {
        if (response == null || response.loading) {
          return _buildLoader();
        }

        if (response.hasErrors) {
          basicGqlErrorHandler(response).then(
              (f) => handleFailure(f, context, withPrefix: widget.errorText));
          return _resultFromCache != null
              ? widget.onResponse(_resultFromCache!)
              : widget.error ??
                  Text(
                    widget.errorText ?? 'error',
                    style: const TextStyle(color: Colors.red),
                  );
        }

        _resultFromCache = response.data;

        return widget.onResponse(response.data!);
      },
      client: _client,
    );
  }

  Widget _buildLoader() {
    return widget.loader ??
        const Loader(
          size: 12,
        );
  }
}
