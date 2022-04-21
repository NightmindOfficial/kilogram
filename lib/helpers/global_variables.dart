import 'package:flutter/material.dart';
import 'package:kilogram/screens/add_post_screen.dart';
import 'package:kilogram/screens/feed_screen.dart';

import '../screens/search_screen.dart';

const int webScreenSize = 600;

const List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Notif"),
  Text("Account"),
];
