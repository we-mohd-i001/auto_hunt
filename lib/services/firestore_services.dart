import '../constants/firebase_consts/firebase_consts.dart';

class FireStoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getCars(brand) {
    return firestore
        .collection(carsCollection)
        .where('car_brand', isEqualTo: brand)
        .snapshots();
  }
}
