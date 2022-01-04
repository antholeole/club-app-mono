import 'dart:typed_data';

import 'package:fe/stdlib/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_image_change_state.freezed.dart';

@freezed
class ClubImageChangeState with _$ClubImageChangeState {
  factory ClubImageChangeState.notChanging([Uint8List? image]) = _NotChanging;
  factory ClubImageChangeState.changing([Uint8List? image]) = _Changing;
  factory ClubImageChangeState.failure(Failure failure, [Uint8List? image]) =
      _Failure;
}
