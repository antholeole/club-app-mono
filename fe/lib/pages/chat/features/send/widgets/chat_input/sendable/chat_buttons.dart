import 'package:fe/stdlib/shared_widgets/no_overflow_crossfade.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../service_locator.dart';

final Color _iconColor = Colors.grey.shade500;

class ChatButtons extends StatelessWidget {
  final bool _isOpen;
  final void Function() _manuallyShowButtons;
  final void Function(XFile) _pickedImage;

  const ChatButtons(
      {Key? key,
      required bool isOpen,
      required void Function(XFile) pickedImage,
      required void Function() manuallyShowButtons})
      : _isOpen = isOpen,
        _pickedImage = pickedImage,
        _manuallyShowButtons = manuallyShowButtons,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoOverflowCrossfade(
      firstChild: Row(children: [
        IconButton(
            onPressed: () => getIt<ImagePicker>()
                .pickImage(source: ImageSource.gallery)
                .then((image) => image == null ? null : _pickedImage(image)),
            icon: Icon(
              Icons.photo,
              color: _iconColor,
            )),
      ]),
      secondChild: IconButton(
          onPressed: _manuallyShowButtons,
          icon: Icon(
            Icons.chevron_right_outlined,
            color: _iconColor,
          )),
      crossFadeState:
          _isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 100),
    );
  }
}
