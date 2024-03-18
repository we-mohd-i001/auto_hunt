import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_auto_complete.dart';

Widget searchWidget(){
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: InputAutoComplete(
      optionsBackgroundColor: Colors.white,
      isShadowEnabled: true,
      icon: FontAwesomeIcons.magnifyingGlass,
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