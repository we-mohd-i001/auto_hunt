import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';

import '../constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';

class ProfileController extends GetxController {
  RxString profileImagePath = ''.obs;
  String profileImageLink = '';
  RxBool isPasswordVisible = true.obs;
  RxBool isLoading = false.obs;
  RxBool isImageLoading = false.obs;
  RxBool isImageUploadButtonDisabled = true.obs;
  RxBool isNameSuffixIconDisabled = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
    String destination = 'images/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  Future<void> updateName(String name) async {
    DocumentReference<Map<String, dynamic>> store =
    firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set(
      {'name': name},
      SetOptions(merge: true),
    );
    isNameSuffixIconDisabled(true);
  }

  Future<void> updateProfileImage(String imageUrl) async {
    final DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({'imageUrl': imageUrl}, SetOptions(merge: true));
    isImageLoading(false);

    Alerts.showSuccessToast!(content: 'Profile image updated.');
    isImageUploadButtonDisabled(true);
  }

  Future<void> changeAuthPassword(String email, String password, String newPassword) async {
    final AuthCredential cred =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword).catchError((e) {
        debugPrint(e.toString());
      });
    });
  }

  Future<void> updatePassword(String password) async {
    DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set(
      {'password': password},
      SetOptions(merge: true),
    );
    isLoading(false);
  }
}
