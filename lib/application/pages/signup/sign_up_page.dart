import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yourtasks/application/pages/login/controller/auth_controller.dart';
import 'package:yourtasks/constants/consts.dart';
import 'package:yourtasks/vaahextendflutter/widgets/atoms/buttons.dart';
import 'package:yourtasks/vaahextendflutter/widgets/atoms/input_text.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/button_checkbox.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../home/my_home_page.dart';

class SignupPage extends StatefulWidget {
  static const String routePath = '/signup';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const SignupPage(),
    );
  }

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = false;
  bool isRetypePasswordVisible = false;
  bool isCheck = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
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
                            text: 'By checking this box you agree to the terms and conditions.', data: Text)
                      ],
                      onChanged: (items) {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      }),
                  SizedBox(
                    width: double.infinity,
                    child:
                    Obx(() => controller.isLoading.value ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Colors.green),
                      ),) :
                    ButtonElevated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (isCheck != false) {
                            try {
                              await controller
                                  .signUpMethod(_emailController.text,
                                      _passwordController.text)
                                  .then((value) {
                                return controller.storeUserData(
                                    _nameController.text,
                                    _passwordController.text,
                                    _emailController.text);
                              }).then((value) {
                                Get.snackbar('Success', 'SignUp Successful');
                                //TODO : Add named route here
                                Get.offAllNamed(MyHomePage.routePath);
                              });
                            } catch (e) {
                              auth.signOut();
                              Get.snackbar('Error', 'Something went wrong, ${e.toString()}');
                              debugPrint('Signup Error');
                            }
                          }

                          debugPrint('Name: ${_nameController.text}');
                          debugPrint('Email: ${_emailController.text}');
                          debugPrint('Password: ${_passwordController.text}');
                        }
                      },
                      text: "Sign Up",
                      fontSize: 17,
                      buttonType:
                          !isCheck ? ButtonType.secondary : ButtonType.success,
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
