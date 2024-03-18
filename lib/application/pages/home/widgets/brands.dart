import 'package:flutter/material.dart';

Widget brands(image) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            image,
          ),
        ),
      ),
    ),
  );
}