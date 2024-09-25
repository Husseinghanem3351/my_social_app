import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/models/post_model.dart';

import '../../../shared/components.dart';
import '../../../shared/widgets/default_button.dart';
import '../../../shared/widgets/extended_image.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.post, required this.index});
  final PostModel post;
  final int index;
  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      onTap: () {
        navigateTo(
            context: context,
            screen: DefaultExtendedImage(
              post: post,
              index: index,
              url: post.postImage!,
            ));
      },
      buttonWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: CachedNetworkImageProvider(post.postImage!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
