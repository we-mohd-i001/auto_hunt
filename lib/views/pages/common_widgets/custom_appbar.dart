// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../helpers/commons.dart';
import '../../../helpers/constants/constants.dart';
import '../../../vaahextendflutter/app_theme.dart';

PreferredSizeWidget? customAppBar(
    {dynamic implyLeading,
    void Function()? onPressed,
    required String title,
    List<Widget>? actions}) {
  return AppBar(
    automaticallyImplyLeading: implyLeading ?? true,
    backgroundColor: AppTheme.colors['secondary']![100],
    surfaceTintColor: AppTheme.colors['secondary']![100],
    leading: implyLeading ?? true
        ? IconButton(
            tooltip: Strings.back,
            icon: const Icon(Icons.arrow_back),
            onPressed: onPressed ?? () {},
          )
        : null,
    title: Text(
      title,
      style: heading,
    ),
    actions: actions ?? [],
  );
}
