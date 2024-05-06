import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage.dart';

class FirebaseNetworkStorage implements Storage {
  final String collectionName;
  FirebaseNetworkStorage({required this.collectionName});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;

  ///in case of multiple documents the methods take List<documentName>
  ///and List<jsonData> as argument and returns List<jsonResult>

  @override
  Future<void> create({dynamic key, dynamic value}) async {
    // if (isMultiple) {
    //   if (documentName.lenght == jsonData.lenght) {
    //     for (int i = 0; i < documentName.lenght; i++) {
    //       await _firestore.collection(collectionName).doc(documentName[i]).set({
    //         'data': jsonData[i],
    //       });
    //     }
    //   } else {
    //     throw Exception('List Length mismatch.');
    //   }
    // } else {
    //   await _firestore
    //       .collection(collectionName)
    //       .doc(documentName)
    //       .set({'data': jsonData});
    // }
  }

  @override
  void delete({dynamic key}) {
    if (key.runtimeType is List) {
      for (int i = 0; i < key.lenght; i++) {
        _firestore.collection(collectionName).doc(key[i]).delete();
      }
    }
    _firestore.collection(collectionName).doc(key).delete();
  }

  @override
  Future<void> init() async {
    if (_auth.currentUser != null) {
      currentUser = _auth.currentUser;
    } else {
      throw FirebaseAuthException(
          code: '',
          message:
              'The FirebaseAuth.intance.currentUser returns null, User not authenticated. Handle this exception to ensure unauthorized access to firestore.');
    }
  }

  @override
  Future<dynamic> read({dynamic key}) async {
    String? value;
    if (key.runtimeType is List) {
      for (int i = 0; i < key.lenght; i++) {
        _firestore.collection(collectionName).doc(key[i]).get();
      }
    }
    await _firestore
        .collection(collectionName)
        .doc(key)
        .get()
        .then((v) => value = v.data()!['data']);
    return value;
  }

  @override
  Future<dynamic> update({dynamic key, dynamic value}) async {
    //   if (isMultiple) {
    //     if (key.runtimeType is List) {
    //       for (int i = 0; i < key.lenght; i++) {
    //         await _firestore
    //             .collection(collectionName)
    //             .doc(key[i])
    //             .update({'data': value[i]});
    //       }
    //     }
    //   } else {
    //     await _firestore
    //         .collection(collectionName)
    //         .doc(key)
    //         .update({'data': value});
    //   }
  }
}
