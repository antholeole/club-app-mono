import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../service_locator.dart';

class GqlClient {
  final _handler = getIt<Handler>();

  final Client _client;

  GqlClient({required Client client}) : _client = client;

  Stream<TData> request<TData, TVars>(OperationRequest<TData, TVars> request) {
    return _client.request(request).asyncMap((resp) async {
      if (resp.hasErrors) {
        throw await _handler.basicGqlErrorHandler(resp);
      } else {
        return resp.data!;
      }
    });
  }

  Future<void> mutateFromUi<TData, TVars>(
      OperationRequest<TData, TVars> request, BuildContext context,
      {void Function(TData data)? onComplete,
      required String errorMessage,
      required String successMessage}) async {
    try {
      final res = await this.request(request).first;

      context
          .read<ToasterCubit>()
          .add(Toast(message: successMessage, type: ToastType.Success));

      onComplete?.call(res);
    } on Failure catch (f) {
      _handler.handleFailure(f, context, withPrefix: errorMessage);
    }
  }

  Cache get cache => _client.cache;
  Client get innerClient => _client;
}
