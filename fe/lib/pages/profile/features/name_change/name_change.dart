import 'package:fe/pages/profile/features/name_change/cubit/name_change_cubit.dart';
import 'package:fe/pages/profile/features/name_change/cubit/name_change_state.dart';
import 'package:fe/pages/profile/features/name_change/widgets/name_change_button.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';

class NameChange extends StatelessWidget {
  final Handler _handler = getIt<Handler>();

  NameChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NameChangeCubit, NameChangeState>(
        builder: (context, state) => state.when(
              notChanging: () => const NameChangeButton(loading: false),
              changing: () => const NameChangeButton(loading: true),
              failure: (_) => const NameChangeButton(loading: false),
            ),
        listener: (context, state) => state.maybeWhen(
              orElse: () => null,
              failure: (failure) => _handler.handleFailure(failure, context,
                  withPrefix: "Couldn't change name"),
            ));
  }
}
