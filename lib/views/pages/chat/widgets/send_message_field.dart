import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_text.dart';

class SendMessageField extends StatelessWidget {
  final TextEditingController? controller;
  final dynamic Function()? onSendTap;
  const SendMessageField(
      {super.key, required this.controller, required this.onSendTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ContainerWithRoundedBorder(
        borderRadius: 8,
        padding: allPadding0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: InputText(
            controller: controller,
            label: 'Type a message...',
            suffixIcon: Icons.send_rounded,
            suffixOnTap: onSendTap!,
          ),
        ),
      ),
    );
  }
}
