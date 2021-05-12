import 'package:fe/data_classes/models/base/base_dao.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

//T MUST overload == operator.
//Treats local as a cache, meaning locals will always be
//changed to match with remote
//TODO: can refactor so remote sync returns the updated list rather than needing to requery

class RemoteSyncer {
  final _gqlClient = getIt<Client>();

  Future<void> remoteSync<T extends DataClass, R extends BaseDao<T>>(
      R repository,
      List<T> locals,
      List<T> remotes,
      Future<void> Function(T) addOneLocal,
      Future<void> Function(T) removeOneLocal,
      String Function(T) debugName) {
    List<Future<void>> changes = [];
    for (T remote in remotes) {
      if (locals.indexWhere((local) => local == remote) < 0) {
        debugPrint(
            'adding ${T.runtimeType.toString()} ${debugName(remote)} locally');
        changes.add(addOneLocal(remote));
      } else {
        changes.add(repository.overrideLocal(remote));
      }
    }

    for (T local in locals) {
      if (remotes.indexWhere((remote) => local == remote) < 0) {
        debugPrint(
            'removing ${T.runtimeType.toString()} ${debugName(local)} locally');
        changes.add(removeOneLocal(local));
      }
    }

    return Future.wait(changes);
  }

  Future<T> fetchRemote<T, GqlData, GqlVars>(
    OperationRequest<GqlData, GqlVars> request,
    T Function(GqlData) dataToT,
  ) async {
    final resp = await _gqlClient.request(request).first;

    if (resp.data == null) {
      throw await basicGqlErrorHandler(errors: resp.graphqlErrors);
    }

    final data = resp.data!;

    return dataToT(data);
  }
}
