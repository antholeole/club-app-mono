part of 'toaster_cubit.dart';

class ToasterState {
  final Map<UuidType, Toast> _toasts;

  ToasterState() : _toasts = {};

  ToasterState.fromOther(ToasterState toasterState)
      : _toasts = {...toasterState._toasts};

  @override
  bool operator ==(covariant ToasterState other) {
    return mapEquals(other._toasts, _toasts);
  }

  List<Toast> get toasts =>
      _toasts.values.toList()..sort((a, b) => a.created.compareTo(b.created));

  void add(Toast toast) {
    _toasts[toast.id] = toast;
  }

  Toast? remove(UuidType toastId) {
    return _toasts.remove(toastId);
  }
}
