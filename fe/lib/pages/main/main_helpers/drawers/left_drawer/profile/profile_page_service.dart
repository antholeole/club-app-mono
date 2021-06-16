import 'package:fe/gql/update_self_name.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:ferry/ferry.dart';

class ProfilePageService {
  final _user = getIt<LocalUser>();
  final _gqlClient = getIt<Client>();

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

    final query = GUpdateSelfNameReq((b) => b
      ..vars.id = _user.uuid
      ..vars.name = newName);

    final resp = await _gqlClient.request(query).first;

    if (resp.hasErrors) {
      throw await basicGqlErrorHandler(resp);
    }

    _user.name = resp.data!.update_users_by_pk!.name;
  }
}

class GUserReq {}
