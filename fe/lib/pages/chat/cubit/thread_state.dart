import 'package:equatable/equatable.dart';
import 'package:fe/data/models/thread.dart';
import 'package:flutter/cupertino.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

@immutable
class ThreadState extends Union2Impl<NoThreadState, WithThreadState> {
  static const unions = Doublet<NoThreadState, WithThreadState>();

  ThreadState._(Union2<NoThreadState, WithThreadState> union) : super(union);

  factory ThreadState.noThread() =>
      ThreadState._(unions.first(const NoThreadState()));

  factory ThreadState.thread(Thread Thread) =>
      ThreadState._(unions.second(WithThreadState(thread: Thread)));

  Thread? get thread {
    return join((_) => null, (ts) => ts.thread);
  }
}

class NoThreadState extends Equatable {
  const NoThreadState();

  @override
  List<Object?> get props => [];
}

class WithThreadState extends Equatable {
  final Thread thread;

  const WithThreadState({required this.thread});

  @override
  List<Object?> get props => [Thread, thread];
}
