import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/user.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future Create({required User user}) async {
    await _firestore.collection("users").doc(user.id).set(user.toJson());
  }

  Future Update({required User user}) async {
    await _firestore.collection("users").doc(user.id).update(user.toJson());
  }

  Future Delete({required String id}) async {
    await _firestore.collection("users").doc(id).delete();
  }
}
