import 'package:flutter/material.dart';
import 'count_container.dart';

Widget likedAndOrderedCars() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      countContainer('00', 'Liked Cars'),
      countContainer('00', 'Your Orders')
    ],
  );
}