import 'package:flutter/material.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/button_checkbox.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../common_widgets/logo_with_name.dart';

class ContinueWithEmailPage extends StatefulWidget {
  static const String routePath = '/with_email';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ContinueWithEmailPage(),
    );
  }

  const ContinueWithEmailPage({super.key});

  @override
  State<ContinueWithEmailPage> createState() => _ContinueWithEmailPageState();
}

class _ContinueWithEmailPageState extends State<ContinueWithEmailPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LogoWithName(
                    size: 15,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '''Login''',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 36,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hello, Welcome back',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 60),

                  ContainerWithRoundedBorder(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const InputText(
                              padding: EdgeInsets.all(16),
                              keyboardType: TextInputType.emailAddress,
                              suffixIcon: Icons.email,
                              label: 'Email',
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 1,
                            ),
                            InputText(
                              padding: const EdgeInsets.all(16),

                              // keyboardType: TextInputType.visiblePassword,
                              isPassword: isPasswordVisible,
                              suffixIcon: isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixOnTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              label: 'Password',
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Hero(
                                tag: 'hero1',
                                child: ButtonElevated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  onPressed: () {},
                                  text: "Login",
                                  fontSize: 17,
                                  buttonType: ButtonType.success,
                                  foregroundColor: AppTheme.colors['white'],
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    ButtonCheckBox(items: const[
                      CheckboxItem(text: 'Remember me!',  data: Text)
                    ], onChanged: (items){
                      setState(() {

                      });
                    })
                  ],),
                  // const Spacer(),
                  // const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
