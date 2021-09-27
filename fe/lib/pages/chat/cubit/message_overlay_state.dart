part of 'message_overlay_cubit.dart';

@immutable
class MessageOverlayState extends Union3Impl<MessageOverlayNone,
    MessageOverlaySettings, MessageOverlayReactions> {
  @override
  String toString() =>
      join((a) => a.toString(), (a) => a.toString(), (a) => a.toString());

  static const unions = Triplet<MessageOverlayNone, MessageOverlaySettings,
      MessageOverlayReactions>();

  MessageOverlayState._(
      Union3<MessageOverlayNone, MessageOverlaySettings,
              MessageOverlayReactions>
          union)
      : super(union);

  factory MessageOverlayState.none() =>
      MessageOverlayState._(unions.first(MessageOverlayNone()));

  factory MessageOverlayState.settings(
          {required LayerLink layerLink, required Message message}) =>
      MessageOverlayState._(unions.second(
          MessageOverlaySettings(layerLink: layerLink, message: message)));

  factory MessageOverlayState.reactions({
    required LayerLink layerLink,
    required Message message,
  }) =>
      MessageOverlayState._(unions.third(
          MessageOverlayReactions(layerLink: layerLink, message: message)));

  Message? get message =>
      join((_) => null, (mos) => mos.message, (mor) => mor.message);
}

//all states intentionally do not extend equatable;
//doing so would make it so that if the same state was triggered,
//it would not reemit the state. This is not the goal; if a user taps
//an already tapped message, we want to be able to react appropriately.
class MessageOverlayNone {}

class MessageOverlaySettings {
  final LayerLink layerLink;
  final Message message;

  const MessageOverlaySettings(
      {required this.layerLink, required this.message});
}

class MessageOverlayReactions {
  final LayerLink layerLink;
  final Message message;

  const MessageOverlayReactions(
      {required this.layerLink, required this.message});
}
