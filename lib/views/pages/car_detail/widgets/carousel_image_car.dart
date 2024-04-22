import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../helpers/commons.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';

class CarouselImageCar extends StatelessWidget {
  final String? heroTag;
  final List? carImagesList;
  const CarouselImageCar({super.key, this.heroTag, this.carImagesList});

  @override
  Widget build(BuildContext context) {
    if (carImagesList == null) {
      return emptyWidget;
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              initialPage: 0,
            ),
            itemCount: carImagesList!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Hero(
                      tag: heroTag ?? '${Random().nextInt(55)}',
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: PhotoView(
                          backgroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          imageProvider: NetworkImage(
                            carImagesList![itemIndex],
                          ),
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ContainerWithRoundedBorder(
                        color: AppTheme.colors['secondary']![50] as Color,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        borderRadius: 6,
                        child: Text(
                          '${itemIndex + 1}',
                          style: normal,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
