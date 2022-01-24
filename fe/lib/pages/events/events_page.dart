import 'package:fe/data/models/group.dart';
import 'package:fe/pages/events/features/calandar/calandar.dart';
import 'package:fe/pages/events/features/event_creator/event_creator.dart';
import 'package:fe/pages/scaffold/widgets/scaffold_button.dart';
import 'package:provider/provider.dart';
import 'package:fe/pages/scaffold/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatefulWidget {
  const EventsPage();

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        actionButtons: [
          if (context.watch<Club>().admin)
            ScaffoldButton(
                icon: Icons.add,
                onPressed: (_) =>
                    Navigator.of(context).push(EventCreator.route(context)))
        ],
        titleBarWidget: Text(_selectedDate != null
            ? DateFormat.yMMMMd('en_US').format(_selectedDate!)
            : 'No Day Selected'),
        child: Calandar(
          onSelectNewDate: (newDate) => setState(() {
            _selectedDate = newDate;
          }),
        ));
  }
}
