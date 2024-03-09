import 'package:flutter/material.dart';
import 'package:yourtasks/application/pages/home/my_home_page.dart';
import 'package:yourtasks/application/pages/login/login_page.dart';
import 'package:yourtasks/application/pages/view_states/continue_with_email_page.dart';
import '../views/pages/home.dart';
import '../views/pages/not_found.dart';
import '../views/pages/permission_denied.dart';
import '../views/pages/ui/index.dart';

final Map<String, Route<dynamic> Function()> routes = {
  '/': MyHomePage.route,
  LoginPage.routePath: LoginPage.route,
  ContinueWithEmailPage.routePath: ContinueWithEmailPage.route,
  MyHomePage.routePath: MyHomePage.route,
  NotFoundPage.routePath: NotFoundPage.route,
  PermissionDeniedPage.routePath: PermissionDeniedPage.route,
  UIPage.routePath: UIPage.route,
};
