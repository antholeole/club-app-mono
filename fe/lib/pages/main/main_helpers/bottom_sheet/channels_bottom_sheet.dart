import 'package:fe/stdlib/theme/search_bar.dart';
import 'package:flutter/material.dart';

class ChannelsBottomSheet extends StatefulWidget {
  @override
  _ChannelsBottomSheetState createState() => _ChannelsBottomSheetState();
}

class _ChannelsBottomSheetState extends State<ChannelsBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _channelSearch = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              SearchBar(
                  controller: _channelSearch,
                  onCancel: _cancelSearch,
                  onClear: _clearSearch,
                  focusNode: _searchFocusNode,
                  animation: _animation,
                  text: 'Jump to...'),
              Expanded(
                  child: ListView(
                children: [
                  _buildSection('Channels', []),
                  _buildSection('Direct Messages', []),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String sectionName, List<Widget> elements) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            sectionName.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'IBM Plex Mono', color: Colors.grey.shade700),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: elements,
        )
      ],
    );
  }

  Widget _buildChannelTile({
    required int unreadMessages,
    required bool selected,
    required String title,
  }) {
    return ListTile(
        tileColor: selected ? Colors.grey.shade200 : Colors.white,
        title: Text(title,
            style: TextStyle(
                fontWeight:
                    unreadMessages != 0 ? FontWeight.bold : FontWeight.normal)),
        leading: Text('#',
            style: TextStyle(
                fontSize: 28,
                fontWeight:
                    unreadMessages > 0 ? FontWeight.bold : FontWeight.normal)),
        trailing: (unreadMessages > 0)
            ? Chip(
                backgroundColor: Colors.red,
                label: Text(
                  unreadMessages.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            : null);
  }

  Widget _buildDmTile(
      {required int unreadMessages,
      required bool selected,
      required String title,
      required bool isOnline}) {
    return ListTile(
        tileColor: selected ? Colors.grey.shade200 : Colors.white,
        title: Text(title,
            style: TextStyle(
                fontWeight:
                    unreadMessages != 0 ? FontWeight.bold : FontWeight.normal)),
        leading: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  isOnline ? null : Border.all(color: Colors.grey, width: 3),
              color: isOnline ? Colors.green : Colors.transparent),
        ),
        trailing: (unreadMessages > 0)
            ? Chip(
                backgroundColor: Colors.red,
                label: Text(
                  unreadMessages.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            : null);
  }

  void _cancelSearch() {
    _channelSearch.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _channelSearch.clear();
  }
}
