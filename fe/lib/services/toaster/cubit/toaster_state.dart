part of 'toaster_cubit.dart';

class ToasterState extends Equatable {
  final Map<UuidType, Toast> _toasts;

  ToasterState() : _toasts = {};

  ToasterState.fromOther(ToasterState toasterState)
      : _toasts = {...toasterState._toasts};

  @override
  List<Object?> get props => [_toasts];

  List<Toast> get toasts =>
      _toasts.values.toList()..sort((a, b) => a.created.compareTo(b.created));

  void add(Toast toast) {
    _toasts[toast.id] = toast;
  }

  Toast? remove(UuidType toastId) {
    return _toasts.remove(toastId);
  }
}
