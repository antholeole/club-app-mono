import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';

@immutable
class SendingMessage extends Equatable {
  final String message;
  final UuidType id;

  SendingMessage({required this.message}) : id = UuidType.generate();

  @override
  List<Object?> get props => [message, id];
}
