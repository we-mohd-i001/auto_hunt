import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../common_widgets/logo_with_name.dart';
import '../view_states/continue_with_email_page.dart';

class LoginPage extends StatelessWidget {
  static const String routePath = '/login';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const LoginPage(),
    );
  }

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (_, constraints){
      final screenWidth = constraints.maxWidth;
      if(screenWidth <=600){
        return buildMobile(context);
      } else if(screenWidth <=840){
        return buildTablet();
      } else{
        return buildTablet();
      }
    });
  }
}

Widget buildMobile(BuildContext context){
 return Scaffold(
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login_page_background.jpg',
                  ),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoWithName(),
              const SizedBox(height: 20),
              const Text(
                '''Let's get started''',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 34,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign up or login to see what',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white70),
              ),
              const Text(
                'happening near you',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white70),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: 'hero1',
                  child: ButtonElevated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    onPressed: () {
                      Navigator.pushNamed(context, ContinueWithEmailPage.routePath);
                    },
                    text: "Continue with Email",
                    fontSize: 17,
                    buttonType: ButtonType.white,
                    foregroundColor: AppTheme.colors['black'],
                    borderRadius: 8,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonOutlinedWithIcon(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  fontSize: 17,
                  onPressed: () {},
                  text: "Continue with Google",


                  // style:  ButtonStyle(
                  //   elevation: MaterialStatePropertyAll(20),
                  //   side: MaterialStatePropertyAll(
                  //     BorderSide(
                  //         color: Colors.grey),
                  //
                  //   ),
                  //
                  //
                  // ),
                  borderRadius: 8,
                  iconData: FontAwesomeIcons.google,
                  iconSize: 19,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonOutlinedWithIcon(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  fontSize: 17,
                  onPressed: () {},

                  text: "Continue with Apple",
                  buttonType: ButtonType.help,

                  borderRadius: 8,
                  iconData: Icons.apple,
                  iconSize: 20,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTablet(){
  return Scaffold(
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login_page_background.jpg',
                  ),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        AssetImage('assets/images/auto_hunt_logo.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Auto.Hunt',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '''Let's get started''',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 34,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign up or login to see what',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white70),
                  ),
                  Text(
                    'happening near you',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white70),
                  ),
                ],
              ),

              const Spacer(),
              SizedBox(width: 350,

                child: Column(children: [
                  const SizedBox(height: 70,),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonElevated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () {},
                      text: "Continue with Email",
                      fontSize: 17,
                      buttonType: ButtonType.white,
                      foregroundColor: AppTheme.colors['black'],
                      borderRadius: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: AppTheme.colors['black'],
                    width: double.infinity,
                    child: ButtonOutlinedWithIcon(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      fontSize: 17,
                      onPressed: () {},
                      foregroundColor: AppTheme.colors['white'],
                      text: "Continue with Google",
                      buttonType: ButtonType.secondary,
                      borderRadius: 8,
                      iconData: FontAwesomeIcons.google,
                      iconSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: AppTheme.colors['black'],
                    width: double.infinity,
                    child: ButtonOutlinedWithIcon(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      fontSize: 17,
                      onPressed: () {},

                      foregroundColor: AppTheme.colors['white'],
                      text: "Continue with Apple",
                      buttonType: ButtonType.secondary,
                      borderRadius: 8,
                      iconData: Icons.apple,
                      iconSize: 20,
                    ),
                  )
                ],),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDeskTop(){
  return const Text('We are not on Desktop.');
}