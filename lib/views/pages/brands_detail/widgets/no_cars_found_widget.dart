import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/constants/constants.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/enums.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';

class NoCarsFoundWidget extends StatelessWidget {
  const NoCarsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: AppBar(
        backgroundColor: AppTheme.colors['secondary']![100],
        surfaceTintColor: AppTheme.colors['secondary']![100],
        leading: IconButton(
            tooltip: Strings.back,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
            )),
      ),
      body: Center(
        child: ButtonOutlined(
          buttonType: ButtonType.danger,
          text: 'No cars Found Go Back',
          borderRadius: 8,
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
