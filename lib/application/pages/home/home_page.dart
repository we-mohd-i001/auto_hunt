import 'package:flutter/material.dart';
import '../../../constants/others/other_consts.dart';
import '../../../constants/strings/strings.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/widgets/atoms/input_auto_complete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
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
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.location,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text('Dwarka, New Delhi',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(OtherConsts.profileImageUrl),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: InputAutoComplete(
                          optionsBackgroundColor: Colors.white,
                          isShadowEnabled: true,
                          icon: Icons.search_rounded,
                          label: Strings.searchHint,
                          hints: [
                            'BMW',
                            'Audi',
                            'Dodge',
                            'Honda',
                            'Hyundai',
                            'Toyota',
                            'Suzuki',
                            'Tesla',
                            'Mercedes',
                            'Nissan'
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(child: homeScreenOptions())
                    ],
                  ),
                ),
              ),
              expandedHeight: 230,
            ),
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 1000 ListTiles
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget homeScreenOptions() {
  return Container(
    alignment: Alignment.bottomLeft,
    width: double.infinity,
    color: AppTheme.colors['primary'],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 0,
            child:
                optionsHomeScreen(Icons.car_rental_rounded, Strings.rentCar)),
        const VerticalDivider(
          color: Colors.grey,
          indent: 10,
          thickness: 1,
          endIndent: 10,
        ),
        Expanded(
            flex: 0,
            child: optionsHomeScreen(Icons.car_repair_rounded, Strings.buyCar)),
        const VerticalDivider(
          color: Colors.grey,
          indent: 10,
          thickness: 1,
          endIndent: 10,
        ),
        Expanded(
            flex: 0,
            child:
                optionsHomeScreen(Icons.car_crash_rounded, Strings.sellCar)),
      ],
    ),
  );
}

Widget optionsHomeScreen(icon, text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
      Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      )
    ],
  );
}
