import 'package:fe/data/models/group.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/fn_providers/log_outer.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

/// wraps a prompt and injects providers.
/// provides some default providers that are used often
/// but can also specify extras
class PromptInjector extends StatelessWidget {
  final List<Provider> _providers;

  final Widget _child;

  final BuildContext _readableContext;

  const PromptInjector(
      {Key? key,
      required BuildContext readableContext,
      required Widget child,
      List<Provider> providers = const []})
      : _providers = providers,
        _child = child,
        _readableContext = readableContext,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _readableContext.read<ToasterCubit>()),
        Provider.value(value: _readableContext.read<UserCubit>()),
        Provider.value(value: _readableContext.read<LogOuter>()),
        Provider.value(value: _readableContext.read<Group>()),
        ..._providers,
      ],
      child: _child,
    );
  }
}
