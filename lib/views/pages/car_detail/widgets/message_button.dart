// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/enums.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';

class MessageButton extends StatelessWidget {
  final void Function()? onPressed;
  const MessageButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonIcon(
      onPressed: onPressed,
      iconData: Icons.chat_rounded,
      buttonType: ButtonType.primary,
    );
  }
}
