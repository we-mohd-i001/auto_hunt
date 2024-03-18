import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/app_theme.dart';

import '../../../../constants/consts.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  togglePasswordVisibilityLoginPage() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  //login method

  Future<UserCredential?> loginMethod() async {
    UserCredential userCredential;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '', backgroundColor: AppTheme.colors['white'], messageText: Text('Login Unsuccessful ${e.toString()}'));
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
        {'name': name, 'email': email, 'password': password, 'imageUrl': '', 'id': currentUser!.uid});
  }

  signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Sign out Unsuccessful ${e.toString()}');
    }
  }
}
