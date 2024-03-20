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
  var profileImagePath = ''.obs;
  var passwordVisibility = true.obs;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var oldPassController = TextEditingController();

  var profileImageLink = '';
  var isLoading = false.obs;
  var isImageLoading = false.obs;

  togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  changeImage() async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      }
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile(name, password) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set(
      {'name': name, 'password': password},
      SetOptions(merge: true),
    );
    isLoading(false);
  }
  updateProfileImage(imageUrl) async{
    final store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'imageUrl' : imageUrl
    }, SetOptions(merge: true));
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

  authPasswordChange(email, password, newPassword)async{
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword).catchError((e){
        debugPrint(e.toString());
      });
    });
  }
}
