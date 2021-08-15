import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/get_it_helpers.dart';

void main() {
  setUp(() {
    registerAllServices(needCubitAutoEvents: true);
  });
  group('groups page', () {
    //should render groups view
  });

  group('groups view', () {
    //TODO should handle failure (toast, display error)
    //TODO should display no clubs text on no clubs
    //TODO should clubs on clubs
  });
}
