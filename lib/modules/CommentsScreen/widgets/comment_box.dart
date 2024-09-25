import 'package:flutter/material.dart';

import '../../../HomeLayout/cubit/cubit.dart';
import '../../../shared/constants/const.dart';
import '../comments.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.index, this.isShimmer});
  final int index;
  final bool? isShimmer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: TextFormField(
        readOnly: isShimmer??false,
        controller: Comments.commentController,
        decoration: InputDecoration(
            label: const Text('write comment ...'),
            labelStyle: const TextStyle(
                color: Colors.grey
            ),
            border: const OutlineInputBorder(),
            suffixIcon:  IconButton(
                onPressed: () {
                  if(Comments.commentController.text.isNotEmpty&&(isShimmer==null||isShimmer==false)) {
                    SocialCubit.get(context).writeComment ( Comments.commentController.text , index , posts[index]!.postId!) ;
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios)
            )
        ),
      ),
    );
  }
}
