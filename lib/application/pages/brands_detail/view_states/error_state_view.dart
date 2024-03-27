import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(Strings.anErrorOccurred),);
  }
}
