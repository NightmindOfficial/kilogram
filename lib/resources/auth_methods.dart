import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kilogram/models/user.dart' as model;
import 'package:kilogram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign Up
  Future<String> signupUser(
    String mail,
    String pass,
    String uname,
    String bio,
    Uint8List? file,
  ) async {
    String res = "An unknown error occurred.";
    try {
      if (mail.isNotEmpty &&
          pass.isNotEmpty &&
          uname.isNotEmpty &&
          file != null) {
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass);

        log("New User created with UID " + _cred.user!.uid);

        //Upload image
        String profilePictureUrl = await StorageMethods()
            .uploadImageToStorage('profilePictures', file, false);

        // Create User Model

        model.User user = model.User(
          uid: _cred.user!.uid,
          email: mail,
          uname: uname,
          profilePictureUrl: profilePictureUrl,
          bio: bio,
          followers: [],
          following: [],
        );

        //Add User to Firestore
        await _firestore
            .collection('users')
            .doc(_cred.user!.uid)
            .set(user.userToJson());
        res = "Login:Success";
      } else if (file == null) {
        res = "Du musst ein Profilbild hochladen.";
      } else {
        res = "Du hast noch nicht alle Felder ausgefüllt.";
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }
    log(res);
    return res;
  }

  //Log in user
  Future<String> logInUser(String mail, String pass) async {
    String res = "An unknown error occurred.";

    try {
      if (mail.isNotEmpty && pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: mail, password: pass);
        res = "Login:Success";
      } else {
        res = "Du hast nicht alle Felder ausgefüllt.";
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }
    log(res);
    return res;
  }

  // Get User Info from Firestore

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.snapToUser(snap);
  }
}
