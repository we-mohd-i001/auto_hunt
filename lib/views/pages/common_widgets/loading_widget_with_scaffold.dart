import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';

class LoadingWidgetWithScaffold extends StatelessWidget {
  const LoadingWidgetWithScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.colors['secondary']![100],
        body: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
