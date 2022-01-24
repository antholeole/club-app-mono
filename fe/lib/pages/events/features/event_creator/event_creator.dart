import 'package:fe/data/models/group.dart';
import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/all_day_switch.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_date.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_description.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_name.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_repeats.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_time.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/event_until_date.dart';
import 'package:fe/pages/events/features/event_creator/widgets/form_fields/submit_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class EventCreator extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<bool>> _allDayToggleKey =
      GlobalKey<FormFieldState<bool>>();
  final GlobalKey<FormFieldState<DateTime>> _startDateKey =
      GlobalKey<FormFieldState<DateTime>>();
  final GlobalKey<FormFieldState<DateTime>> _endDateKey =
      GlobalKey<FormFieldState<DateTime>>();
  final GlobalKey<FormFieldState<List<bool>>> _repeatsKey =
      GlobalKey<FormFieldState<List<bool>>>();

  EventCreator({Key? key}) : super(key: key);

  static PageRoute route(BuildContext context) {
    return platformPageRoute(
        context: context,
        builder: (_) =>
            Provider.value(value: context.read<Club>(), child: EventCreator()));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<EventCreatorFormCubit>(
      create: (context) => EventCreatorFormCubit(),
      builder: (context, _) {
        final fields = _getFields(context);

        return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Create New Event',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  child: ListView(
                    children: [
                      ...fields.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: e,
                          )),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  List<Widget> _getFields(BuildContext context) {
    return [
      const EventName(),
      const EventDescription(),
      AllDaySwitch(context: context, key: _allDayToggleKey),
      EventTimeField(context: context, allDayToggleKey: _allDayToggleKey),
      EventDate(context: context, key: _startDateKey),
      EventRepeats(
        context: context,
        key: _repeatsKey,
        until: _endDateKey,
      ),
      EventUntilDate(
          key: _endDateKey,
          context: context,
          startDate: _startDateKey,
          repeats: _repeatsKey),
      SubmitEventButton(
        formKey: _formKey,
      )
    ];
  }
}
