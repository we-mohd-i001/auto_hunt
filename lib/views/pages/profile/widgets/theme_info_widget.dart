import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/widgets/atoms/tab_options.dart';

class ThemeInfo extends StatelessWidget {
  const ThemeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabOptions(
      tabs: [
        TabOption(
          name: 'Light',
          tab: Text(
              'A  Pleasing  Light  Theme  which  can  enerzige  you  througout  the  day.'),
        ),
        TabOption(
          name: 'Dark',
          tab: Text(
              'A  Pleasing  Dark  Theme  which  can  prevent  your  eyes  from  straining  througout  the  Night.'),
        ),
        TabOption(
          name: 'Aqua',
          tab: Text('An  Ocean  based  theme.'),
        ),
        TabOption(
          name: 'Flora',
          tab: Text('Green  trees  based  theme'),
        ),
        TabOption(
          name: 'Grey Scale',
          tab: Text('Grey  Scales  everything  thorought  the  app.'),
        ),
      ],
    );
  }
}
