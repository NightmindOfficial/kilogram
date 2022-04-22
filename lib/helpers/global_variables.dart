import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kilogram/screens/add_post_screen.dart';
import 'package:kilogram/screens/feed_screen.dart';
import 'package:kilogram/screens/profile_screen.dart';

import '../screens/search_screen.dart';

const int webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(
    child: Text("Favorites would appear on this screen."),
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
