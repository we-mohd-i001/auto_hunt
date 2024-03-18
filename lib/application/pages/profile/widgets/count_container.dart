import 'package:flutter/material.dart';

Widget countContainer(count, type) {
  return Container(
    height: 80,
    width: 160,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(count), Text(type)],
      ),
    ),
  );
}