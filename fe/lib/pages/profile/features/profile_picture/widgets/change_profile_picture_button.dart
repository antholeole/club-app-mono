import 'package:badges/badges.dart';
import 'package:fe/pages/profile/features/profile_picture/cubit/profile_picture_change_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChangeProfilePictureButton extends StatelessWidget {
  final Widget _child;

  const ChangeProfilePictureButton({required Widget child, Key? key})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
        toAnimate: false,
        badgeColor: Colors.black54,
        badgeContent: GestureDetector(
          onTap: context.read<ProfilePictureChangeCubit>().updateProfilePicture,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
        child: _child);
  }
}
