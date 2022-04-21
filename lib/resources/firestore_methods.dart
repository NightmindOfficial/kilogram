import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kilogram/models/post.dart';
import 'package:kilogram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload a post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String uname,
    String profileImage,
  ) async {
    String res = "An unknown error occurred.";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      // Create Post
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        uname: uname,
        postId: postId,
        datePublished: DateTime.now(),
        photoUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );

      //...and upload it to Firestore
      _firestore.collection('posts').doc(postId).set(post.postToJson());
      res = "Upload:Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//Like a post

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
