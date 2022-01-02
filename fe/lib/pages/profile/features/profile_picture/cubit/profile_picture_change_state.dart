import 'dart:typed_data';

import 'package:fe/stdlib/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_picture_change_state.freezed.dart';

@freezed
class ProfilePictureChangeState with _$ProfilePictureChangeState {
  factory ProfilePictureChangeState.notChanging([Uint8List? image]) =
      _NotChanging;
  factory ProfilePictureChangeState.changing([Uint8List? image]) = _Changing;
  factory ProfilePictureChangeState.failure(Failure failure,
      [Uint8List? image]) = _Failure;
}
