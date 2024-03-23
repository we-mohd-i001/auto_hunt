import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';

Widget carBio(String? name, String? fuelAndType, String? image, width, carRent,
    seatCapacity, Function()? onPressed, String tag) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Container(
      height: 240,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              verticalMargin4,
              verticalMargin2,
              Text(
                fuelAndType ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppTheme.colors['secondary']),
              ),
              image == null
                  ? SizedBox(height: 140, width: width,)
                  : Hero(
                    tag: tag,
                    child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
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
                    verticalMargin4,
                    Text('$seatCapacity'),
                    verticalMargin8,
                    Icon(
                      Icons.cable_rounded,
                      size: 16,
                      color: AppTheme.colors['primary'],
                    ),
                    verticalMargin4,
                    const Text('AM'),
                    const Spacer(),
                    Text('₹$carRent/day')
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    ),
  );
}
