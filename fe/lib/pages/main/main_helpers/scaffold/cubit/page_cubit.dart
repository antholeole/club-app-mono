import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(const PageInitial());

  void setPage(int to) => emit(PageUpdate(currentPage: to));
}
