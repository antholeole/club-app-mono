import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/features/club_tab/update_club_image/cubit/club_image_change_cubit.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ClubImage extends StatelessWidget {
  const ClubImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Avatar.club(
      club: context.watch<Club>(),
      imageOverride: context.watch<ClubImageChangeCubit>().state.image,
    );
  }
}
