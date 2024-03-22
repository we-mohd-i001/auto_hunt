import 'package:flutter/material.dart';

Widget brands(image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
            ),
          ),
          child: const SizedBox(
            height: 56,
            width: 56,
          ),

        ),
      ),
    ),
  );
}