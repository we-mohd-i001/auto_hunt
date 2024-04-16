import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';

import '../helpers/constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';

class ProfileController extends GetxController {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  User? currentFirebaseUser;
  RxString profileImageUrl = ''.obs;
  RxString profileImagePath = ''.obs;
  String profileImageLinkFromFirebaseStorage = '';
  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  RxBool isImageLoading = false.obs;
  RxBool isImageUploadButtonDisabled = true.obs;
  RxBool isNameTextFieldIconButtonDisabled = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();

  @override
  void onInit() {
    currentFirebaseUser = fireAuth.currentUser;
    super.onInit();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> updateUiImageUrl() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentFirebaseUser!.uid)
        .snapshots();
    return data;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> changeImage() async {
    try {
      final XFile? img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (img == null) {
        return;
      }
      isImageUploadButtonDisabled(false);
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      Alerts.showErrorDialog!(
        title: 'Error',
        messages: [(e.toString())],
      );
    }
  }

  Future<void> uploadProfileImage() async {
    String fileName = basename(profileImagePath.value);
    String destination = 'images/${currentFirebaseUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLinkFromFirebaseStorage = await ref.getDownloadURL();
  }

  Future<void> updateName(String name) async {
    DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentFirebaseUser!.uid);
    await store.set(
      {'name': name},
      SetOptions(merge: true),
    );
    isNameTextFieldIconButtonDisabled(true);
  }

  Future<void> updateProfileImage(String imageUrl) async {
    final DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentFirebaseUser!.uid);
    await store.set({'imageUrl': imageUrl}, SetOptions(merge: true));
    isImageLoading(false);

    Alerts.showSuccessToast!(content: 'Profile image updated.');
    isImageUploadButtonDisabled(true);
  }

  Future<void> changeAuthPassword(
      String email, String password, String newPassword) async {
    final AuthCredential cred =
        EmailAuthProvider.credential(email: email, password: password);
    await currentFirebaseUser!.reauthenticateWithCredential(cred).then((value) {
      currentFirebaseUser!.updatePassword(newPassword).catchError((e) {
        debugPrint(e.toString());
      });
    });
  }

  Future<void> updatePassword(String password) async {
    try {
      DocumentReference<Map<String, dynamic>> store =
          firestore.collection(usersCollection).doc(currentFirebaseUser!.uid);
      await store.set(
        {'password': password},
        SetOptions(merge: true),
      );
      isLoading(false);
    } on Exception catch (_) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
    }
  }
}
