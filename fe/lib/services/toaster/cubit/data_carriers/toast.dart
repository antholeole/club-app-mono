import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';

enum ToastType {
  Warning,
  Error,
  Success,
}

class ToastAction extends Equatable {
  final String actionText;
  final void Function() action;

  const ToastAction({required this.actionText, required this.action});

  @override
  List<Object?> get props => [actionText];
}

class Toast extends Equatable {
  final UuidType id;
  final String message;
  final ToastType type;
  final VoidCallback? onDismiss;
  final ToastAction? action;

  final DateTime created;
  final DateTime? expireAt;

  Toast({
    UuidType? id,
    required this.message,
    required this.type,
    this.onDismiss,
    bool expire = true,
    this.action,
  })  : id = id ?? UuidType.generate(),
        created = clock.now(),
        expireAt = expire ? clock.now().add(const Duration(seconds: 10)) : null;

  Toast.customExpire({
    UuidType? id,
    required this.message,
    required this.type,
    required this.expireAt,
    this.onDismiss,
    this.action,
  })  : id = id ?? UuidType.generate(),
        created = DateTime.now();

  @override
  List<Object?> get props => [message, id, created, type];
}
