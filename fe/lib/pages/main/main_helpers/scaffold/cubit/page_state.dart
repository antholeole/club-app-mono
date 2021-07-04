part of 'page_cubit.dart';

@immutable
abstract class PageState {
  final int currentPage;

  const PageState({required this.currentPage});
}

class PageInitial extends PageState {
  const PageInitial() : super(currentPage: 0);
}

class PageUpdate extends PageState {
  const PageUpdate({required int currentPage})
      : super(currentPage: currentPage);
}
