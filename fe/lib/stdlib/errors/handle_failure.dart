import 'package:fe/pages/main/main_service.dart';
import 'package:flutter/cupertino.dart';

import '../../service_locator.dart';
import '../toaster.dart';
import 'failure.dart';
import 'failure_status.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

void handleFailure(Failure f, BuildContext context, {String? withPrefix}) {
  if (f.status == FailureStatus.GQLRefresh) {
    getIt<MainService>().logOut(context, true);
  } else {
    String errorString = f.message ?? f.status.message;

    if (withPrefix != null) {
      errorString = withPrefix + ': ' + errorString;
    }

    Toaster.of(context).errorToast(errorString);
  }
}
