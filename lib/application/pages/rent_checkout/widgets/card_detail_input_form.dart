import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/helpers/enums.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../../views/pages/ui/components/commons.dart';

Widget cardDetailInputForm(rentCheckoutController) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12)),
    height: double.infinity,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: rentCheckoutController.cardDetailFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.enterYourCardDetailsMessage,
                style: normal,
              ),
              verticalMargin8,
              InputText(
                keyboardType: TextInputType.number,
                label: Strings.cardNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.enterCardNumberMessage;
                  } else if (value.length != 16) {
                    return Strings.mustBe16Digits;
                  }
                  return null;
                },
                onChanged: (value) {
                  rentCheckoutController.cardDetailFormKey.currentState!.validate();
                  rentCheckoutController.addCardNumber(value);
                },
              ),
              verticalMargin8,
              InputText(
                keyboardType: TextInputType.name,
                label: Strings.cardHolder,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.cardHolderMessage;
                  } else if (value.length > 24) {
                    return Strings.nameTooLong;
                  }
                  return null;
                },
                onChanged: (value) {
                  rentCheckoutController.cardDetailFormKey.currentState!.validate();
                  rentCheckoutController.addCardHolder(value);
                },
              ),
              verticalMargin8,
              Row(
                children: <Widget>[
                  Expanded(
                    child: InputText(
                      label: Strings.enterExpiryDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.enterExpiryDateMessage;
                        } else if (value.length != 4) {
                          Strings.invalidDate;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        rentCheckoutController.cardDetailFormKey.currentState!.validate();
                        rentCheckoutController.addExpiryDate(value);
                      },
                    ),
                  ),
                  horizontalMargin8,
                  Expanded(
                    child: InputText(
                      isPassword: true,
                      maxLines: 1,
                      label: Strings.cvv,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.enterCvvMessage;
                        } else if (value.length != 3) {
                          return Strings.mustBe3Digits;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        rentCheckoutController.cardDetailFormKey.currentState!.validate();
                        rentCheckoutController.addCvv(value);
                      },
                    ),
                  ),
                ],
              ),
              verticalMargin16,
              Row(
                children: [
                  ButtonOutlined(
                    borderRadius: 8,
                    buttonType: ButtonType.success,
                    onPressed: () {
                      if (rentCheckoutController.cardDetailFormKey.currentState!
                          .validate()) {
                        rentCheckoutController.addCardDetails();
                        rentCheckoutController.rentCheckoutFormKey.currentState!.validate();
                        Get.back();
                      }
                    },
                    text: 'Submit',
                  ),
                  horizontalMargin8,
                  ButtonOutlined(
                    borderRadius: 8,
                    buttonType: ButtonType.danger,
                    onPressed: () {
                      Get.back();
                    },
                    text: 'Back',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
