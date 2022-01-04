import 'dart:typed_data';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ProfilePicture extends StatelessWidget {
  final Uint8List? _image;
  static const PFP_RADIUS = 50.0;

  const ProfilePicture({Key? key, Uint8List? image})
      : _image = image,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Avatar.user(
      imageOverride: _image,
      radius: PFP_RADIUS,
      user: context.watch<UserCubit>().user,
    );
  }
}
