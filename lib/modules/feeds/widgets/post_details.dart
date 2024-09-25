import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/models/post_model.dart';
import 'package:my_social_app/modules/feeds/widgets/post_bottom_sheet.dart';

import '../../../HomeLayout/cubit/cubit.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            SocialCubit.get(context).openProfile(post.uid!, context);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(post.image!),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${post.name}',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 16,
                  )
                ],
              ),
              Text(
                post.dateTime!.substring(0, 16),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            postBottomSheet(context,post);
          },
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_horiz,
            ),
          ),
        )
      ],
    );
  }
}
