import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final Map<String, dynamic> datastream;
  const CommentCard({
    Key? key,
    required this.datastream,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 16.0,
      ),
      child: Row(children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.datastream['profilePic']),
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.datastream['username'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " ${widget.datastream['comment']}",
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                  ),
                  child: Text(
                    DateFormat.yMMMMd()
                        .format(widget.datastream['datePublished'].toDate()),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.favorite_outline_rounded,
            size: 16,
          ),
        ),
      ]),
    );
  }
}
