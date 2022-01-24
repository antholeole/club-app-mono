import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCreatorFormCubit extends Cubit<EventCreatorFormState> {
  EventCreatorFormCubit() : super(EventCreatorFormState());

  void update(EventCreatorFormState newState) {
    emit(newState);
  }

  void get() {
    print(state);
  }
}
