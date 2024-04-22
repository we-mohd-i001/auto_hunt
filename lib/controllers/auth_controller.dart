import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  //login with email & password
  Future<UserCredential?> login() async {
    UserCredential? user;
    try {
      isLoading(true);
      user = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (_) {
      Alerts.showErrorToast!(content: 'Login unsuccessful');
    } catch (e) {
      Alerts.showErrorToast!(content: 'Login unsuccessful');
    } finally {
      isLoading(false);
    }

    return user;
  }

  //signup wiwth Email & and password
  Future<UserCredential?> signUp(String email, String password) async {
    UserCredential? userCredential;
    try {
      isLoading(true);
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      Alerts.showErrorToast!(content: 'SignUp unsuccessful!');
    } catch (e) {
      auth.signOut();
      Alerts.showErrorToast!(content: 'Signup unsuccessful');
    } finally {
      isLoading(false);
    }
    return userCredential;
  }

  //storing data to cloud
  Future<void> storeUserData(String name, String password, String email) async {
    try {
      DocumentReference store =
          firestore.collection(usersCollection).doc(auth.currentUser!.uid);
      store.set(
        {
          'name': name,
          'email': email,
          'password': password,
          'imageUrl': '',
          'id': auth.currentUser!.uid,
          'liked_cars_count': "00",
          'order_count': "00",
        },
      );
    } catch (_) {
      Alerts.showErrorToast!(content: 'Something went worng!');
    }
  }

  Future<void> logOut() async {
    try {
      isLoading(true);
      await auth.signOut();
      Alerts.showSuccessToast!(content: 'Logged out successfully.');
    } catch (e) {
      Alerts.showErrorToast!(content: 'LogOut unsuccessful');
    } finally {
      isLoading(false);
    }
  }
}
