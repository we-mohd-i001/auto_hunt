import 'package:flutter/material.dart';

import '../views/pages/login/continue_with_email_page.dart';
import '../views/pages/login/login_page.dart';
import '../views/pages/main_navigator/main_navigator.dart';
import '../views/pages/profile/profile_edit_page.dart';
import '../views/pages/signup/sign_up_page.dart';
import '../views/pages/splash/splash_page.dart';
import '../views/pages/not_found.dart';
import '../views/pages/permission_denied.dart';
import '../views/pages/ui/index.dart';

final Map<String, Route<dynamic> Function()> routes = {
  SplashPage.routePath: SplashPage.route,
  LoginPage.routePath: LoginPage.route,
  ProfileEditPage.routePath: ProfileEditPage.route,
  SignupPage.routePath: SignupPage.route,
  ContinueWithEmailPage.routePath: ContinueWithEmailPage.route,
  MyHomePage.routePath: MyHomePage.route,
  NotFoundPage.routePath: NotFoundPage.route,
  PermissionDeniedPage.routePath: PermissionDeniedPage.route,
  UIPage.routePath: UIPage.route,
};
