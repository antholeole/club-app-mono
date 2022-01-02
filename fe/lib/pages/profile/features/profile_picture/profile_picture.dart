import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/features/profile_picture/cubit/profile_picture_change_cubit.dart';
import 'package:fe/pages/profile/features/profile_picture/cubit/profile_picture_change_state.dart';
import 'package:fe/pages/profile/features/profile_picture/widgets/change_profile_picture_button.dart';
import 'package:fe/pages/profile/features/profile_picture/widgets/profile_picture.dart';

import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';

class SelfProfilePicture extends StatelessWidget {
  SelfProfilePicture({Key? key}) : super(key: key);

  final _handler = getIt<Handler>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: BlocConsumer<ProfilePictureChangeCubit, ProfilePictureChangeState>(
          listener: (context, state) => state.maybeWhen(
              orElse: () => null,
              failure: (f, _) => _handler.handleFailure(f, context)),
          builder: (context, state) => state.when(
              notChanging: (image) => ChangeProfilePictureButton(
                      child: ProfilePicture(
                    image: image,
                  )),
              failure: (_, image) => ChangeProfilePictureButton(
                      child: ProfilePicture(
                    image: image,
                  )),
              changing: (image) => Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          child: ProfilePicture(
                            image: image,
                          )),
                      const Loader()
                    ],
                  ))),
    );
  }
}
