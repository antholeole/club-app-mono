import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainProvider extends StatelessWidget {
  final Widget _child;

  MainProvider({required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainScaffoldCubit()),
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(create: (_) => MainPageBloc()..add(ResetMainPageEvent()))
      ],
      child: Builder(builder: (_) => MainScaffold(child: _child)),
    );
  }
}
