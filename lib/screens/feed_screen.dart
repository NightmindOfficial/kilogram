import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kilogram/helpers/global_variables.dart';
import 'package:kilogram/helpers/size_guide.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: realScreenWidth() > webScreenSize
          ? webBackgroundColor
          : mobileBackgroundColor,
      appBar: realScreenWidth() > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                "assets/svg/kilogram.svg",
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mark_chat_unread_rounded),
                ),
              ],
            ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
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
              itemBuilder: ((context, index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: realScreenWidth() > webScreenSize
                          ? realScreenWidth() * 0.3
                          : 0,
                      vertical: realScreenWidth() > webScreenSize ? 15 : 0,
                    ),
                    child: PostCard(
                      datastream: snapshot.data!.docs[index].data(),
                    ),
                  )),
            );
          }),
    );
  }
}
