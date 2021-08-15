import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Page Cubit', () {
    blocTest<PageCubit, PageState>('switchTo should switch to proper page',
        build: () => PageCubit(),
        act: (cubit) {
          cubit.switchTo(AppPage.Chat);
          cubit.switchTo(AppPage.Events);
        },
        expect: () => [PageState.chatPage(), PageState.eventPage()]);
  });

  testWidgets(
      'bottom sheet on select should switch to that thread', (tester) async {});
}
