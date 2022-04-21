import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kilogram/models/user.dart' as model;
import 'package:kilogram/providers/user_data_provider.dart';
import 'package:kilogram/resources/firestore_methods.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final Map<String, dynamic> datastream;
  const CommentScreen({Key? key, required this.datastream}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserDataProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Kommentare"),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.datastream['postId'])
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) => CommentCard(
                      datastream: snapshot.data!.docs[index].data(),
                    )));
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 8.0,
          ),
          child: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                user.profilePictureUrl,
              ),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: TextField(
                  controller: _commentsController,
                  decoration: InputDecoration(
                    hintText: "Comment as ${user.uname}",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                  widget.datastream['postId'],
                  _commentsController.text,
                  user.uid,
                  user.uname,
                  user.profilePictureUrl,
                );
                setState(() {
                  _commentsController.clear();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(
                    color: blueColor,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
