import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';

import '../../../../constants/consts.dart';

class ProfileController extends GetxController {
  RxString profileImagePath = ''.obs;
  String profileImageLink = '';
  RxBool passwordVisibility = true.obs;
  RxBool isLoading = false.obs;
  RxBool isImageLoading = false.obs;
  RxBool isDisabled = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();

  togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  changeImage() async {
    try {
      final XFile? img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (img == null) {
        return;
      }
      isDisabled(false);
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  uploadProfileImage() async {
    String fileName = basename(profileImagePath.value);
    String destination = 'images/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfileImage(imageUrl) async {
    final DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({'imageUrl': imageUrl}, SetOptions(merge: true));
    isImageLoading(false);
    Get.snackbar(
      "Success",
      '',
      colorText: Colors.black,
      backgroundColor: Colors.white70,
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.only(top: 20, left: 20),
      margin: const EdgeInsets.only(bottom: 160, left: 20, right: 20),
    );
  }

  authPasswordChange(email, password, newPassword) async {
    final AuthCredential cred =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword).catchError((e) {
        debugPrint(e.toString());
      });
    });
  }

  updateProfile(name, password) async {
    DocumentReference<Map<String, dynamic>> store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set(
      {'name': name, 'password': password},
      SetOptions(merge: true),
    );
    isLoading(false);
  }
}
