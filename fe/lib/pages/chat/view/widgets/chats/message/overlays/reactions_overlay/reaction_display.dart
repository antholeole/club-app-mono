import 'package:badges/badges.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/services/toaster/toaster.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/upsert_reaction.req.gql.dart';
import 'package:provider/src/provider.dart';

import '../../../../../../../../service_locator.dart';

class ReactionDisplay extends StatefulWidget {
  static Duration LIKE_BOUNCE_ANIMATION_DURATION =
      const Duration(milliseconds: 200);
  static Duration LIKE_BG_ANIMATION_DURATION =
      const Duration(milliseconds: 400);
  static Duration TOTAL_ANIMATION_DURATION = const Duration(milliseconds: 550);

  final ReactionType _reactionType;
  final bool _selfReacted;
  final int _likeCount;
  final void Function(bool liked, ReactionType type) _onReacted;
  final UuidType _messageId;
  final UuidType _userId;

  const ReactionDisplay(
      {Key? key,
      required ReactionType reactionType,
      required int reactionCount,
      required bool selfReacted,
      required UuidType messageId,
      required UuidType userId,
      required void Function(bool liked, ReactionType type) onReacted})
      : _reactionType = reactionType,
        _messageId = messageId,
        _userId = userId,
        _selfReacted = selfReacted,
        _likeCount = reactionCount,
        _onReacted = onReacted,
        super(key: key);

  @override
  State<ReactionDisplay> createState() => _ReactionDisplayState();
}

class _ReactionDisplayState extends State<ReactionDisplay>
    with TickerProviderStateMixin {
  final _authGqlClient = getIt<AuthGqlClient>();
  final _handler = getIt<Handler>();

  late final AnimationController _bounceController = AnimationController(
      duration: ReactionDisplay.LIKE_BOUNCE_ANIMATION_DURATION, vsync: this);
  late final AnimationController _bgFadeController = AnimationController(
      duration: ReactionDisplay.LIKE_BG_ANIMATION_DURATION, vsync: this);
  bool _hasBeganAnimation = false;

  @override
  void initState() {
    _bgFadeController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _bgFadeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: _onReacted,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.lightBlue.shade100.withAlpha(
                          (widget._selfReacted
                                  ? IntTween(begin: 255, end: 0)
                                  : IntTween(begin: 0, end: 255))
                              .animate(CurvedAnimation(
                                  parent: _bgFadeController,
                                  curve: Curves.linear))
                              .value),
                      width: 2),
                  color: Colors.lightBlue.shade100.withAlpha(
                      (widget._selfReacted
                              ? IntTween(begin: 100, end: 0)
                              : IntTween(begin: 0, end: 100))
                          .animate(CurvedAnimation(
                              parent: _bgFadeController, curve: Curves.linear))
                          .value),
                  shape: BoxShape.circle),
              child: Badge(
                toAnimate: _hasBeganAnimation,
                position: BadgePosition.topEnd(top: -4, end: -4),
                badgeColor: Colors.red,
                showBadge: _shouldShowBadge(),
                badgeContent: Text(_getLikeCount().toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
                child: ScaleTransition(
                    scale: Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(
                        parent: _bounceController, curve: Curves.easeIn)),
                    child: Text(widget._reactionType.emoji)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _shouldShowBadge() {
    return _getLikeCount() > 0;
  }

  int _getLikeCount() {
    if (!_hasBeganAnimation) {
      return widget._likeCount;
    } else {
      return widget._likeCount + (widget._selfReacted ? -1 : 1);
    }
  }

  Future<void> _onReacted() async {
    if (context.read<Thread>().isViewOnly) {
      context.read<ToasterCubit>().add(Toast(
          message: "Can't react in a view only thread.",
          type: ToastType.Warning));
      return;
    }

    try {
      await _authGqlClient
          .request(GUpsertReactionReq((q) => q
            ..vars.deleted = widget._selfReacted
            ..vars.messageId = widget._messageId
            ..vars.selfId = widget._userId
            ..vars.reaction = widget._reactionType.gql))
          .first;
    } on Failure catch (f) {
      _handler.handleFailure(f, context,
          withPrefix: 'failed reacting to message');
      return;
    }

    setState(() {
      _hasBeganAnimation = true;
    });

    await Future.wait([
      _bounceController.forward().then((_) => _bounceController.reverse()),
      _bgFadeController.forward(),
      Future.delayed(ReactionDisplay.TOTAL_ANIMATION_DURATION)
    ]);

    widget._onReacted(!widget._selfReacted, widget._reactionType);
  }
}
