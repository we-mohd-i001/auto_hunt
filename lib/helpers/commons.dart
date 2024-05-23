import 'package:flutter/material.dart';

import '../vaahextendflutter/app_theme.dart';

TextStyle small = TextStyle(
  fontSize: AppTheme.extraSmall,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black']!.shade400,
);

TextStyle heading = TextStyle(
  fontSize: AppTheme.large,
  fontWeight: FontWeight.bold,
  color: AppTheme.colors['black']!.shade400,
);

TextStyle subheading = TextStyle(
  fontSize: AppTheme.medium,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black']!.shade400,
);

TextStyle normal = TextStyle(
  fontSize: AppTheme.small,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black']!.shade400,
);

TextStyle smallBlack = TextStyle(
  fontSize: AppTheme.extraSmall,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black'],
);

TextStyle normalBlack = TextStyle(
  fontSize: AppTheme.small,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black'],
);

TextStyle subheadingBlack = TextStyle(
  fontSize: AppTheme.medium,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['black'],
);

TextStyle headingBlack = TextStyle(
  fontSize: AppTheme.large,
  fontWeight: FontWeight.bold,
  color: AppTheme.colors['black'],
);

TextStyle smallWhite = TextStyle(
  fontSize: AppTheme.extraSmall,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['white'],
);

TextStyle normalWhite = TextStyle(
  fontSize: AppTheme.small,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['white'],
);

TextStyle subheadingWhite = TextStyle(
  fontSize: AppTheme.medium,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['white'],
);

TextStyle headingWhite = TextStyle(
  fontSize: AppTheme.large,
  fontWeight: FontWeight.bold,
  color: AppTheme.colors['white'],
);

TextStyle smallPrimary = TextStyle(
  fontSize: AppTheme.extraSmall,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['primary'],
);

TextStyle normalPrimary = TextStyle(
  fontSize: AppTheme.small,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['primary'],
);

TextStyle subheadingPrimary = TextStyle(
  fontSize: AppTheme.medium,
  fontWeight: FontWeight.w600,
  color: AppTheme.colors['primary'],
);

TextStyle headingPrimary = TextStyle(
  fontSize: AppTheme.large,
  fontWeight: FontWeight.bold,
  color: AppTheme.colors['primary'],
);

TextStyle message = TextStyle(
  fontSize: AppTheme.small,
  fontWeight: FontWeight.w400,
  color: AppTheme.colors['black'],
);

void smartPrint(Object? obj) {
  print('---> $obj');
}
