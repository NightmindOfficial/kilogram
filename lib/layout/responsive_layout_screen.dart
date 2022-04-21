import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kilogram/providers/user_data_provider.dart';
import 'package:kilogram/helpers/global_variables.dart';
import 'package:provider/provider.dart';

import '../helpers/size_guide.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserDataProvider _userDataProvider = Provider.of<UserDataProvider>(
      context,
      listen: false,
    );
    await _userDataProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    SizeGuide().init(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webScreenLayout;
        } else {
          return widget.mobileScreenLayout;
        }
      },
    );
  }
}
