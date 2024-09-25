import 'package:flutter/material.dart';
import 'package:my_social_app/models/post_model.dart';
import 'package:my_social_app/shared/widgets/default_button.dart';

import '../../../HomeLayout/cubit/cubit.dart';
import '../../../shared/components.dart';
import '../../../shared/constants/const.dart';
import '../../../shared/styles/icon_broken.dart';
import '../../CommentsScreen/comments.dart';
import '../../likesUsers/likes_users.dart';

class ViewReactionAndComments extends StatelessWidget {
  const ViewReactionAndComments({super.key, required this.index, required this.post});
  final int index;
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultButton(
            onTap: () {
              SocialCubit.get(context).usersLikes(index);
              navigateTo(context: context, screen: const LikeUsers());
            },
            buttonWidget: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconBroken.Heart,
                  color: Colors.grey[100],
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${posts[index]?.likesLength}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey[100]),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: DefaultButton(
            onTap: () {
              SocialCubit.get(context).getComments(index);
              navigateTo(
                  context: context,
                  screen: Comments(
                    index: index,
                  ));
            },
            buttonWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  IconBroken.Chat,
                  color: Colors.grey[100],
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${post.commentsLength} comment',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey[100]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
