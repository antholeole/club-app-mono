import 'package:fe/gql/update_self_name.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:ferry/ferry.dart';

class ProfilePageService {
  final _gqlClient = getIt<Client>();
  final _localUserService = getIt<LocalUserService>();

  Future<void> changeName(String newName) async {
    RegExp regex = RegExp(
      r'^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\n]{3,}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!regex.hasMatch(newName)) {
      throw Failure(
          message:
              'Please make sure new name does not contain any special characters and is 3 or more letters.',
          status: FailureStatus.RegexFail);
    }

    final userId = await _localUserService.getLoggedInUserId();

    await gqlReqOrThrowFailure(
        GUpdateSelfNameReq((b) => b
          ..vars.id = userId
          ..vars.name = newName),
        _gqlClient);
  }
}
