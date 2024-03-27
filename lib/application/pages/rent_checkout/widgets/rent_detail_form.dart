import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_date_time.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_slider.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../../views/pages/ui/components/commons.dart';
import '../../common_widgets/learn_more_with_title.dart';
import 'card_detail_input_form.dart';
import 'price_detail_widget.dart';

Widget rentDetailForm(rentCheckoutController) {
  return Form(
    key: rentCheckoutController.rentCheckoutFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputText(
          label: Strings.enterPickupLocation,
        ),
        verticalMargin12,
        InputDateTime(
          label: Strings.chooseStartDate,
          pickerType: PickerType.dateOnly,
          callback: (data) {},
        ),
        verticalMargin12,
        Row(
          children: [
            Text(
              'Select days',
              style: normal,
            ),
            horizontalMargin8,
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: const Border(
                      top: BorderSide(),
                      bottom: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide(),
                    )),
                height: 40,
                width: 50,
                child: Center(
                    child: Text('${rentCheckoutController.rentDays.value}')))
          ],
        ),
        InputSlider(
          precision: 0,
          min: 1,
          max: 10,
          initialValue: rentCheckoutController.rentDays.value,
          step: 1,
          onChanged: (value) => rentCheckoutController.rentDays.value = value,
        ),

        InputText(
            suffixIcon: FontAwesomeIcons.pencil,
            suffixOnTap: () {
              Get.bottomSheet(
                cardDetailInputForm(rentCheckoutController),
              );
            },
            label: Strings.enterCardDetails),
        verticalMargin16,
        learnMoreWithTitle(Strings.priceDetails, changeLearnMore: ''),
        verticalMargin16,
        priceDetailWidget(),
        verticalMargin48,
        verticalMargin32,
        // verticalMargin4,
      ],
    ),
  );
}
