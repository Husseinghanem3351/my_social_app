import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/shared/widgets/default_button.dart';

import '../../../HomeLayout/cubit/cubit.dart';
import '../../../models/post_model.dart';
import '../../../shared/components.dart';
import '../../../shared/constants/const.dart';
import '../../../shared/styles/icon_broken.dart';
import '../../CommentsScreen/comments.dart';

class WriteCommentAndReaction extends StatelessWidget {
  const WriteCommentAndReaction(
      {super.key, required this.index, required this.post});

  final int index;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: CachedNetworkImageProvider(post.image!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'write comment...',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        DefaultButton(
          onTap: () {
            SocialCubit.get(context).likePost(index);
          },
          buttonWidget: Row(
            children: [
              if (SocialCubit.get(context).postsLikes.length > index)
                Icon(
                  IconBroken.Heart,
                  size: 20,
                  color: SocialCubit.get(context).postsLikes[post.postId]
                              ?[uid] ==
                          true
                      ? Colors.red
                      : Colors.white,
                ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Like',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[300],
                    ),
              )
            ],
          ),
        ),
        DefaultButton(
          onTap: () {},
          buttonWidget: Row(
            children: [
              const Icon(
                IconBroken.Message,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Share',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[300],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
