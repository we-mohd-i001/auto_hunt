import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../../vaahextendflutter/widgets/atoms/input_text.dart';

Widget cardDetailInputForm(rentCheckoutController) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12)),
    height: double.infinity,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: rentCheckoutController.carDetailFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Strings.enterYourCardDetailsMessage),
              verticalMargin8,
              InputText(
                label: Strings.cardNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.enterCardNumberMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  rentCheckoutController.addCardNumber(value);
                },
              ),
              verticalMargin8,
              InputText(
                label: Strings.cardHolder,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.cardHolderMessage;
                  }
                  return null;
                },
                onChanged: (value) {
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
                        }
                        return null;
                      },
                      onChanged: (value) {
                        rentCheckoutController.addExpiryDate(value);
                      },
                    ),
                  ),
                  horizontalMargin8,
                  Expanded(
                    child: InputText(
                      label: Strings.cvv,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.enterCvvMessage;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        rentCheckoutController.addCvv(value);
                      },
                    ),
                  ),
                ],
              ),
              verticalMargin16,
              ButtonElevated(
                onPressed: () {
                  if (rentCheckoutController.carDetailFormKey.currentState!
                      .validate()) {}
                },
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}