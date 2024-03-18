import 'package:flutter/material.dart';
import '../../../../vaahextendflutter/app_theme.dart';

Widget carBio(name, fuelAndType, image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Container(
      height: 240,
      width: 220,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              fuelAndType,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppTheme.colors['secondary']),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                ),
              ),
              child: const SizedBox(
                height: 140,
                width: 220,
              ),
            ),
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.person,size: 16, color: AppTheme.colors['primary'],),
                  const SizedBox(width: 4),
                  const Text('4'),
                  const SizedBox(width: 6),
                  Icon(Icons.cable_rounded,size: 16, color: AppTheme.colors['primary'],),
                  const SizedBox(width: 4),
                  const Text('AM'),
                  const Spacer(),
                  const Expanded(child: Text('₹320/d'))
                ],
              ),
            ))
          ],
        ),
      ),
    ),
  );
}
