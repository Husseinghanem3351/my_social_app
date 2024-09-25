import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_social_app/modules/CommentsScreen/widgets/comment_box.dart';
import 'package:my_social_app/modules/CommentsScreen/widgets/shimmer_comment_item.dart';
import 'package:shimmer/shimmer.dart';

class CommentsShimmer extends StatefulWidget {
  const CommentsShimmer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  CommentsShimmerState createState() => CommentsShimmerState();
}

class CommentsShimmerState extends State<CommentsShimmer> {
  final bool _enabled = true;
  final List<int> _heights = [50, 60, 80, 70, 40, 50];

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
    int length = 1 + Random().nextInt(6 - 1);
    _heights.shuffle();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: Colors.grey[500]!.withOpacity(.4),
              highlightColor: Colors.grey[400]!.withOpacity(.3),
              enabled: _enabled,
              child: ListView.separated(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey[700],
                    height: 1,
                  ),
                ),
                itemBuilder: (context, index) =>
                    CommentsShimmerItem(height: _heights[index]),
                itemCount: length,
              ),
            ),
          ),
          CommentBox(index: widget.index, isShimmer: true)
        ],
      ),
    );
  }
}
