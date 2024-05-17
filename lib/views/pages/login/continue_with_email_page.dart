import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/button_checkbox.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../controllers/authentication/auth_controller.dart';
import '../common_widgets/logo_with_name.dart';
import '../main_navigator/main_navigator.dart';
import '../signup/sign_up_page.dart';

class Junk extends StatelessWidget {
  const Junk({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ContinueWithEmailPage extends StatefulWidget {
  const ContinueWithEmailPage({super.key});

  static const String routePath = '/with_email';

  static Route<void> route() {
    initialize();
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ContinueWithEmailPage(),
    );
  }

  static initialize() {
    return Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(
            AuthController(),
          );
  }

  @override
  State<ContinueWithEmailPage> createState() => _ContinueWithEmailPageState();
}

class _ContinueWithEmailPageState extends State<ContinueWithEmailPage> {
  AuthController controller = Get.find<AuthController>();
  void _login() async {
    UserCredential? userCredential = await controller.login().then((value) {
      Get.offAllNamed(MyHomePage.routePath);
    });
    if (userCredential != null) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login_page_background.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
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
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 36,
                      color: AppTheme.colors['white'],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hello, Welcome back',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppTheme.colors['white'],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Stack(
                    children: [
                      Hero(
                          tag: 'hero1',
                          child: Container(
                            height: 280,
                          )),
                      ContainerWithRoundedBorder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InputText(
                                controller: authController.emailController,
                                validator: (_) => 'Invalid email',
                                padding: const EdgeInsets.all(16),
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: Icons.email,
                                label: 'Email',
                                maxLines: 1,
                              ),
                              Obx(
                                () => InputText(
                                  controller: authController.passwordController,
                                  validator: (_) => 'Invalid Password',
                                  padding: const EdgeInsets.all(16),
                                  isPassword:
                                      authController.isPasswordVisible.value,
                                  suffixIcon:
                                      authController.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                  suffixOnTap: () {
                                    authController.togglePasswordVisibility();
                                  },
                                  label: 'Password',
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Obx(
                                  () => authController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              AppTheme.colors['success'],
                                            ),
                                          ),
                                        )
                                      : ButtonElevated(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          onPressed: _login,
                                          text: "Login",
                                          fontSize: 17,
                                          buttonType: ButtonType.success,
                                          foregroundColor:
                                              AppTheme.colors['white'],
                                          borderRadius: 8,
                                        ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonCheckBox(
                                      padding: const EdgeInsets.all(0),
                                      items: const [
                                        CheckboxItem(
                                          text: 'Remember me!',
                                          data: Text,
                                        ),
                                      ],
                                      onChanged: (items) {}),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: AppTheme.colors['danger'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member yet? ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppTheme.colors['white'],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignupPage.routePath);
                          },
                          child: Text(
                            ' Join now',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppTheme.colors['warning'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
