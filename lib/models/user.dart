import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String profilePictureUrl;
  final String uname;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.uname,
    required this.email,
    required this.profilePictureUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> userToJson() => {
        "uid": uid,
        "email": email,
        "username": uname,
        "profilePictureUrl": profilePictureUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static User snapToUser(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      uname: snapshot['username'],
      profilePictureUrl: snapshot['profilePictureUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
