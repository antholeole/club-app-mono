import 'package:ferry/ferry.dart';

abstract class GqlClient {
  Future<TData> request<TData, TVars>(OperationRequest<TData, TVars> request);
}
