import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/scaffold/features/threads_bottom_sheet/widgets/add_thread_dialog.dart';
import 'package:fe/pages/scaffold/features/threads_bottom_sheet/widgets/channel_tile.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';

class ThreadGroup<TData, TVars> extends StatelessWidget {
  static const String ERROR_TEXT = 'Error loading threads';
  static const String NO_THREADS = "You're not in any threads yet!";

  final Iterable<Thread> Function(TData) _dataMap;
  final OperationRequest<TData, TVars> _operationRequest;
  final bool _addable;
  final String _title;
  final Thread? _selectedThread;

  const ThreadGroup(
      {Key? key,
      Thread? selectedThread,
      required UuidType currentGroupId,
      required Iterable<Thread> Function(TData) dataMap,
      required OperationRequest<TData, TVars> operationRequest,
      required bool addable,
      required String title})
      : _title = title,
        _addable = addable,
        _selectedThread = selectedThread,
        _operationRequest = operationRequest,
        _dataMap = dataMap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        Row(
          children: [
            Text(
              _title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'IBM Plex Mono', color: Colors.grey.shade700),
            ),
            if (_addable)
              GestureDetector(
                  onTap: () => AddThreadDialog.show(context).then(
                      (maybeThread) => maybeThread != null
                          ? _selectThread(maybeThread, context)
                          : null),
                  child: const Icon(Icons.add, color: Colors.grey))
          ],
        ),
        GqlOperation<TData, TVars>(
            operationRequest: _operationRequest,
            errorText: ERROR_TEXT,
            onResponse: (TData data) {
              final threads = _dataMap(data);

              if (threads.isNotEmpty) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: threads
                        .map((v) => Thread(
                            name: v.name, id: v.id, isViewOnly: v.isViewOnly))
                        .map((v) => ChannelTile(
                            viewOnly: v.isViewOnly,
                            unreadMessages: 2,
                            onTap: () => _selectThread(v, context),
                            selected: v == _selectedThread,
                            title: v.name))
                        .toList());
              } else {
                return Container(
                  child: const Center(child: Text(NO_THREADS)),
                );
              }
            })
      ],
    ));
  }

  void _selectThread(Thread v, BuildContext context) {
    Navigator.of(context).pop(v);
  }
}
