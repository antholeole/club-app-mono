import 'package:fe/pages/groups/features/club_tab/update_club_image/cubit/club_image_change_cubit.dart';
import 'package:fe/pages/groups/features/club_tab/update_club_image/cubit/club_image_change_state.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';

class UpdateClubImage extends StatelessWidget {
  final _handler = getIt<Handler>();

  UpdateClubImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClubImageChangeCubit, ClubImageChangeState>(
      listener: (_, state) => state.maybeWhen(
          orElse: () => null,
          failure: (f, _) => _handler.handleFailure(f, context)),
      child: ListTile(
        title: const Text('Change Group Image'),
        onTap: context.read<ClubImageChangeCubit>().updateImage,
      ),
    );
  }
}
