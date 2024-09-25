import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/models/comment_model.dart';

import '../../../HomeLayout/cubit/cubit.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            SocialCubit.get(context).openProfile(commentModel.uid!, context);
          },
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                commentModel.image!),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${commentModel.name}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .displaySmall,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '${commentModel.comment}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        color: Colors.white70,
                        fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
