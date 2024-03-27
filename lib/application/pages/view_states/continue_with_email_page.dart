import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/button_checkbox.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../common_widgets/logo_with_name.dart';
import '../login/controller/auth_controller.dart';
import '../main_navigator/main_navigator.dart';
import '../signup/sign_up_page.dart';

class Junk extends StatelessWidget {
  const Junk({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ContinueWithEmailPage extends StatelessWidget {
  static const String routePath = '/with_email';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ContinueWithEmailPage(),
    );
  }

  const ContinueWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
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
                    'Login',
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
                                controller: controller.emailController,
                                validator: (_) => 'Invalid email',
                                padding: const EdgeInsets.all(16),
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: Icons.email,
                                label: 'Email',
                                maxLines: 1,
                              ),
                              Obx(
                                () => InputText(
                                  controller: controller.passwordController,
                                  validator: (_) => 'Invalid Password',
                                  padding: const EdgeInsets.all(16),

                                  // keyboardType: TextInputType.visiblePassword,
                                  isPassword:
                                      controller.isPasswordVisible.value,
                                  suffixIcon: controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  suffixOnTap: () {
                                    controller
                                        .togglePasswordVisibilityLoginPage();
                                  },
                                  label: 'Password',
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Obx(
                                  () => controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.green),
                                          ),
                                        )
                                      : ButtonElevated(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          onPressed: () async {
                                            controller.isLoading(true);
                                            //_formKey.currentState?.validate();
                                           UserCredential? userCredential =  await controller.login();
                                            if(userCredential != null){
                                            } else {
                                              controller.isLoading(false);
                                            }
                                            controller.isLoading(false);
                                          },
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
                                            text: 'Remember me!', data: Text)
                                      ],
                                      onChanged: (items) {}),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: AppTheme.colors['danger']),
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
                        const Text(
                          'Not a member yet? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white),
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
                                color: AppTheme.colors['warning']),
                          ),
                        ),
                      ],
                    ),
                  ),

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
