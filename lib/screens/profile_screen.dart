import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilogram/resources/auth_methods.dart';
import 'package:kilogram/resources/firestore_methods.dart';
import 'package:kilogram/screens/login_screen.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/utils/snackbar_creator.dart';
import 'package:kilogram/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {
    'username': '',
    'profilePictureUrl': '',
    'bio': '',
  };
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowingUser = false;
  bool isOwnProfile = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnap = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // Get Post Length
      var postSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength = postSnapshot.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowingUser = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      isOwnProfile = widget.uid == FirebaseAuth.instance.currentUser!.uid;
      setState(() {});
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondaryColor,
                          backgroundImage: NetworkImage(
                            userData['profilePictureUrl'],
                          ),
                          radius: 40,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatisticColumn(postLength, "Posts"),
                                  buildStatisticColumn(followers, "Followers"),
                                  buildStatisticColumn(following, "Following"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  isOwnProfile
                                      ? FollowButton(
                                          text: "Ausloggen",
                                          backgroundColor:
                                              mobileBackgroundColor,
                                          textColor: primaryColor,
                                          borderColor: Colors.grey,
                                          function: () async {
                                            AuthMethods().signOut();
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    const LoginScreen()),
                                              ),
                                            );
                                          },
                                        )
                                      : isFollowingUser
                                          ? FollowButton(
                                              text: "Nicht mehr folgen",
                                              backgroundColor:
                                                  mobileBackgroundColor,
                                              textColor: blueColor,
                                              borderColor: blueColor,
                                              function: () async {
                                                FirestoreMethods().followUser(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  userData['uid'],
                                                );
                                                setState(() {
                                                  isFollowingUser = false;
                                                  followers--;
                                                });
                                              },
                                            )
                                          : FollowButton(
                                              text: "Folgen",
                                              backgroundColor: blueColor,
                                              textColor: primaryColor,
                                              borderColor: blueColor,
                                              function: () async {
                                                FirestoreMethods().followUser(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  userData['uid'],
                                                );
                                                setState(() {
                                                  isFollowingUser = true;
                                                  followers++;
                                                });
                                              },
                                            ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        userData['username'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        userData['bio'],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1.5,
                              mainAxisSpacing: 1.5,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        DocumentSnapshot<Map<String, dynamic>> snap =
                            snapshot.data!.docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(
                              snap['photoUrl'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }),
            ]),
          );
  }

  Column buildStatisticColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
