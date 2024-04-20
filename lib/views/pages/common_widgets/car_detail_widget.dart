import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../helpers/commons.dart';

class CarDetailWidget extends StatelessWidget {
  final String? name;
  final String? fuelAndType;
  final String? image;
  final double? width;
  final int carRent;
  final String? seatCapacity;
  final void Function()? onPressed;
  final String tag;
  const CarDetailWidget(
      {super.key,
      required this.name,
      required this.fuelAndType,
      required this.image,
      required this.width,
      required this.carRent,
      required this.seatCapacity,
      required this.onPressed,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        height: 260,
        width: width,
        decoration: BoxDecoration(
          color: AppTheme.colors['white'],
          boxShadow: [
            BoxShadow(
              color: AppTheme.colors['secondary']!.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(name ?? '', style: subheadingBlack),
                    ),
                  ],
                ),
                verticalMargin4,
                verticalMargin2,
                Text(fuelAndType ?? '', style: normal),
                image == null
                    ? SizedBox(
                        height: 140,
                        width: width,
                      )
                    : Hero(
                        tag: tag,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                image!,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            height: 140,
                            width: width,
                          ),
                        ),
                      ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: AppTheme.colors['primary'],
                        ),
                        horizontalMargin4,
                        Text(
                          '$seatCapacity',
                          style: normal,
                        ),
                        verticalMargin8,
                        Icon(
                          Icons.cable_rounded,
                          size: 16,
                          color: AppTheme.colors['primary'],
                        ),
                        horizontalMargin4,
                        Text(
                          'AM',
                          style: normal,
                        ),
                        const Spacer(),
                        Text(
                          '₹$carRent/day',
                          style: normalBlack,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
