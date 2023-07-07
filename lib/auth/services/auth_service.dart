// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes/user/services/user_service.dart';

import "../../user/domain/user.dart" as us;
class AuthSService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserService _userService = UserService();

  Future Loging({required String email, required String password}) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }


  Future register({
    required String name,
    required String email,
    required String password,
  }) async  {
    var response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    us.User user = us.User(
      name: name,
      email: email,
      id: response.user!.uid,
    );
    _userService.Create(user: user);
  }
}
