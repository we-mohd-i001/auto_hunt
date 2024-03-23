import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../common_widgets/learn_more_with_title.dart';
import 'widgets/home_screen_options.dart';
import 'widgets/location_and_profile.dart';
import 'widgets/most_popular_cars.dart';
import 'widgets/search_by_brands.dart';
import 'widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey.shade100,
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: null,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppTheme.colors['black'],
                  child: Column(
                    children: [
                      locationAndProfile(),
                      searchWidget(),
                      verticalMargin8,
                      Expanded(child: homeScreenOptions()),
                    ],
                  ),
                ),
              ),
              expandedHeight: 230,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                learnMoreWithTitle(Strings.searchByBrand),
                searchByBrands(),
                learnMoreWithTitle(Strings.mostPopularCars),
                mostPopularCars(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
