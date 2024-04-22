import 'package:flutter/material.dart';

import '../../../helpers/commons.dart';
import '../../../vaahextendflutter/app_theme.dart';

class ErrorWidgetWithScaffold extends StatelessWidget {
  final String errorText;
  const ErrorWidgetWithScaffold({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.colors['secondary']![100],
        body: Center(
          child: Text(errorText, style: normal),
        ));
  }
}
