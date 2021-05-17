import 'package:flutter/cupertino.dart';

import '../../pages/main/cubit/main_page_actions_cubit.dart';
import '../toaster.dart';
import 'failure.dart';
import 'failure_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void handleFailure(Failure f, BuildContext context, {String? withPrefix}) {
  if (f.status == FailureStatus.GQLRefresh) {
    context.read<MainPageActionsCubit>().logout(withError: true);
  } else {
    String errorString = f.message;

    if (withPrefix != null) {
      errorString = withPrefix + ' ' + errorString;
    }

    Toaster.of(context).errorToast(errorString);
  }
}
