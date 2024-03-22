import 'package:flutter/material.dart';
import 'package:yourtasks/application/pages/common_widgets/car_bio.dart';
import 'package:yourtasks/constants/others/other_consts.dart';

import '../../../data/models/brands/brands_model.dart';

class BrandsDetailPage extends StatelessWidget {
  final Brand data;
  const BrandsDetailPage({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars From ${data.name}'),
      ),
      body: SafeArea(
        child: SizedBox(
            height: size.height,
            child: ListView.builder(
                  itemCount: data.cars.length,
                  itemBuilder: (BuildContext context, int index) {

                    return carBio(data.cars[index], data.name,
                        OtherConsts.carBMWM8, double.infinity);
                  }),
            ),
      ),
    );
  }
}
