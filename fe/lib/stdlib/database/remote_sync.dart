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

  Future<void> remoteSync<T extends DataClass, U extends UpdateCompanion<T>>(
      {required Iterable<U> locals,
      required Iterable<U> remotes,
      required Future<void> Function(U) upsert,
      required Future<void> Function(U) removeOneLocal,
      required bool Function(U, U) compareEquality}) {
    List<Future<void>> changes = [];
    Set<U> elementsNotFound = locals.toSet();

    for (U remote in remotes) {
      changes.add(upsert(remote));
      elementsNotFound
          .removeWhere((element) => compareEquality(element, remote));
    }

    for (U elementNotFound in elementsNotFound) {
      changes.add(removeOneLocal(elementNotFound));
      debugPrint('removing ${elementNotFound.toString()}');
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
