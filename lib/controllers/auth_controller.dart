import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';
import '../application/pages/main_navigator/main_navigator.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  void togglePasswordVisibilityLoginPage() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  //login method

  Future<UserCredential?> login() async {
    //UserCredential userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Alerts.showSuccessToast!(content: 'Logged in successfully.');
      Get.offAllNamed(MyHomePage.routePath);
    } on FirebaseAuthException catch (e) {
      Alerts.showErrorToast!(content: 'Login unsuccessful');
    }
  }

  // signUp method
  Future<UserCredential?> signUp(String email, String password) async {
    //UserCredential userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Alerts.showErrorToast!(content: 'SignUp unsuccessful!');
    }
  }

  //storing data to cloud

  Future<void> storeUserData(String name, String password, String email) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
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

  Future<void> logOut() async {
    try {
      await auth.signOut();
      Alerts.showSuccessToast!(content: 'Logged out successfully.');
    } catch (e) {
      Alerts.showErrorToast!(content: 'LogOut unsuccessful');
    }
  }
}
