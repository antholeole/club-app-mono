import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart';
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
  final _client = getIt<AuthGqlClient>();
  final _handler = getIt<Handler>();
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

    return FutureBuilder<TData>(
      future: widget.operationRequest != null
          ? _client.request(widget.operationRequest!)
          : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoader();
        }

        if (snapshot.error is Failure) {
          _handler.handleFailure(snapshot.error as Failure, context,
              withPrefix: widget.errorText);

          return _resultFromCache != null
              ? widget.onResponse(_resultFromCache!)
              : widget.error ??
                  Text(
                    widget.errorText ?? 'error',
                    style: const TextStyle(color: Colors.red),
                  );
        }

        final response = snapshot.data;
        _resultFromCache = response;
        return widget.onResponse(response!);
      },
    );
  }

  Widget _buildLoader() {
    return widget.loader ??
        const Loader(
          size: 12,
        );
  }
}
