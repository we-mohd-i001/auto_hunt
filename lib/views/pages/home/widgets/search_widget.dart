import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/widgets/atoms/input_text.dart';

Widget searchWidget(Function()? onSelected) {
  return InputText(
    label: 'Search cars...',
    suffixIcon: Icons.search,
    suffixOnTap: onSelected,
  );
}
