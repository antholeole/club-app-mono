import 'dart:convert';

import 'package:http/http.dart';

Future<StreamedResponse> buildSuccessfulGqlResponse(Map<String, dynamic> data) {
  return Future<StreamedResponse>.value(
    StreamedResponse(
      Stream.value(utf8.encode(jsonEncode({'data': data}))),
      200,
    ),
  );
}

Future<StreamedResponse> buildFailedGqlResponse(List<String> errors) {
  final errorResp = {
    'errors': errors.map((e) => {'message': e}).toList()
  };

  return Future<StreamedResponse>.value(
    StreamedResponse(
      Stream.value(utf8.encode(jsonEncode(errorResp))),
      200,
    ),
  );
}
