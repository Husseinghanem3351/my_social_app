import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_social_app/modules/feeds/widgets/post_details.dart';
import 'package:my_social_app/modules/feeds/widgets/post_image.dart';
import 'package:my_social_app/modules/feeds/widgets/tags.dart';
import 'package:my_social_app/modules/feeds/widgets/view_reaction_and_comments.dart';
import 'package:my_social_app/modules/feeds/widgets/write_comment_and_reaction.dart';
import 'package:my_social_app/shared/components.dart';
import '../../../models/post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post, required this.index});

  final PostModel post;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: HexColor('1E1C1C'),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 20,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostDetails(post: post),
              if(post.text!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  '${post.text}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 6 == 5 ? 2 : null,
                  overflow: TextOverflow.visible,
                ),
              ),
              if(post.tags!=null)
               Tags(postModel: post,),
              if (post.postImage != null)
                PostImage(
                  post: post,
                  index: index,
                ),
              ViewReactionAndComments(
                index: index,
                post: post,
              ),
              const MyDivider(
                bottomPadding: 0,
              ),
              WriteCommentAndReaction(index: index, post: post),
            ],
          ),
        ),
      ),
    );
  }
}
