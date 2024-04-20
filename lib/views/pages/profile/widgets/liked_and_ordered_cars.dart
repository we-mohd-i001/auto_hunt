import 'package:flutter/material.dart';
import 'count_container.dart';

class LikedAndOrderedCars extends StatelessWidget {
  final String likedCount;
  final String orderCount;
  const LikedAndOrderedCars(
      {super.key, required this.likedCount, required this.orderCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountContainer(count: likedCount, type: 'Liked Cars'),
        CountContainer(count: orderCount, type: 'Your Orders')
      ],
    );
  }
}
