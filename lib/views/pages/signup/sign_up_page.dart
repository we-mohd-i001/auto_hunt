import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/alerts.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/button_checkbox.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../controllers/auth_controller.dart';
import '../common_widgets/custom_appbar.dart';
import '../main_navigator/main_navigator.dart';

class SignupPage extends StatefulWidget {
  static const String routePath = '/signup';

  static Route<void> route() {
    _initialize();
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const SignupPage(),
    );
  }

  static _initialize() {
    return Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(
            AuthController(),
          );
  }

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  void _signUp(String email, String password) async {
    UserCredential? userCredential =
        await controller.signUp(email, password).then((value) {
      return controller.storeUserData(_nameController.text,
          _passwordController.text, _emailController.text);
    }).then((value) {
      Alerts.showSuccessToast!(content: 'SignUp Successful');
      Get.offAllNamed(MyHomePage.routePath);
    });
    if (userCredential != null) {
    } else {
      Alerts.showErrorToast!(content: 'Something went wrong!');
    }
  }

  bool isPasswordVisible = false;
  bool isRetypePasswordVisible = false;
  bool isEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![50],
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: 'Sign Up',
        onPressed: () {
          Get.back();
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ContainerWithRoundedBorder(
            height: 480,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InputText(
                    padding: const EdgeInsets.all(16),
                    suffixIcon: Icons.person,
                    label: 'Name',
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      if (value!.length < 2) {
                        return 'Does your name contains only one letter?';
                      }
                      return null;
                    },
                  ),
                  InputText(
                    padding: const EdgeInsets.all(16),
                    suffixIcon: Icons.email,
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  InputText(
                    padding: const EdgeInsets.all(16),
                    isPassword: isPasswordVisible,
                    suffixIcon: isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    suffixOnTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    maxLines: 1,
                    label: 'Password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  InputText(
                    padding: const EdgeInsets.all(16),
                    maxLines: 1,
                    label: 'Retype password',
                    controller: _retypePasswordController,
                    isPassword: isRetypePasswordVisible,
                    suffixIcon: isRetypePasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    suffixOnTap: () {
                      setState(() {
                        isRetypePasswordVisible = !isRetypePasswordVisible;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please retype your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  ButtonCheckBox(
                      padding: const EdgeInsets.all(0),
                      items: const [
                        CheckboxItem(
                            text:
                                'By checking this box you agree to the terms and conditions.',
                            data: Text)
                      ],
                      onChanged: (items) {
                        setState(() {
                          isEnabled = !isEnabled;
                        });
                      }),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  AppTheme.colors['success'],
                                ),
                              ),
                            )
                          : ButtonElevated(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (isEnabled != false) {
                                    _signUp(_emailController.text,
                                        _passwordController.text);
                                  }
                                }
                              },
                              text: "Sign Up",
                              fontSize: 17,
                              buttonType: !isEnabled
                                  ? ButtonType.secondary
                                  : ButtonType.success,
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
      ),
    );
  }
}
