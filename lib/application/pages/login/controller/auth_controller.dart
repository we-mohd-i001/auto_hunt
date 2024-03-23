import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/consts.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../main_navigator/main_navigator.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  togglePasswordVisibilityLoginPage() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  //login method

  Future<UserCredential?> loginMethod() async {
    UserCredential userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Get.snackbar('Success', 'Logged in successfully.',
          backgroundColor: AppTheme.colors['white'], borderRadius: 6);
      Get.offAllNamed(MyHomePage.routePath);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '',
          backgroundColor: AppTheme.colors['white'],
          messageText: Text('Login Unsuccessful ${e.toString()}'));
    }
  }

  // signUp method
  Future<UserCredential?> signUpMethod(email, password) async {
    UserCredential userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'SignUp Unsuccessful ${e.toString()}');
    }
  }

  //storing data to cloud

  storeUserData(name, password, email) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set(
      {
        'name': name,
        'email': email,
        'password': password,
        'imageUrl': '',
        'id': currentUser!.uid,
        'liked_cars_count': "00",
        'order_count': "00",
      },
    );
  }

  signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Sign out Unsuccessful ${e.toString()}');
    }
  }
}
