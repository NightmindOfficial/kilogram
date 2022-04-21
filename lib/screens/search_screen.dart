import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kilogram/utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            decoration: const InputDecoration(
              labelText: "Suche nach Benutzern",
            ),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: _searchController.text,
                    )
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.docs[index]['profilePictureUrl'],
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docs[index]['username'],
                            ),
                          )),
                    );
                  }
                })
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: ((BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => Image.network(
                        snapshot.data!.docs[index]['photoUrl'],
                        fit: BoxFit.cover,
                      ),
                      staggeredTileBuilder: (index) => StaggeredTile.count(
                          (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                    );
                  }
                })));
  }
}
