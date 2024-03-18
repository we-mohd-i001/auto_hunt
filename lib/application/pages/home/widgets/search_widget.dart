import 'package:flutter/material.dart';

import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_auto_complete.dart';

Widget searchWidget(){
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: InputAutoComplete(
      optionsBackgroundColor: Colors.white,
      isShadowEnabled: true,
      icon: Icons.search_rounded,
      label: Strings.searchHint,
      hints: [
        'BMW',
        'Audi',
        'Dodge',
        'Honda',
        'Hyundai',
        'Toyota',
        'Suzuki',
        'Tesla',
        'Mercedes',
        'Nissan'
      ],
    ),
  );
}