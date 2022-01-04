import 'package:fe/pages/groups/features/club_tab/update_club_image/cubit/club_image_change_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UpdateClubImage extends StatelessWidget {
  const UpdateClubImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Change Group Image'),
      onTap: context.read<ClubImageChangeCubit>().updateImage,
    );
  }
}
