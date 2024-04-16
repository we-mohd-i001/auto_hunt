import 'package:flutter/material.dart';
import 'count_container.dart';

Widget likedAndOrderedCars(likedCount, orderCount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      countContainer('$likedCount', 'Liked Cars'),
      countContainer('$orderCount', 'Your Orders')
    ],
  );
}