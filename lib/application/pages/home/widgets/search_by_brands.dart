import 'package:flutter/material.dart';
import '../../../../constants/others/other_consts.dart';
import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'brands.dart';

Widget searchByBrands() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(Strings.searchByBrand),
            Text(
              Strings.learnMore,
              style: TextStyle(color: AppTheme.colors['secondary']),
            )
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            brands(OtherConsts.bmwLogo),
            brands(OtherConsts.teslaLogo),
            brands(OtherConsts.mercedesLogo),
            brands(OtherConsts.toyotaLogo),
            brands(OtherConsts.nissanLogo),
            brands(OtherConsts.profileImageUrl),
            brands(OtherConsts.profileImageUrl),
            brands(OtherConsts.profileImageUrl),
          ],
        ),
      ),
    ],
  );
}


