import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_consts/firebase_consts.dart';

class FireStoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCars(brand) {
    return firestore
        .collection(carsCollection)
        .where('car_brand', isEqualTo: brand)
        .snapshots();
  }
}
