import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String uname;
  final String postId;
  final DateTime datePublished;
  final String photoUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.uname,
    required this.postId,
    required this.datePublished,
    required this.photoUrl,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> postToJson() => {
        "description": description,
        "uid": uid,
        "username": uname,
        "postId": postId,
        "datePublished": datePublished,
        "photoUrl": photoUrl,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post snapToPost(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      uname: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      photoUrl: snapshot['photoUrl'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
    );
  }
}
