import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/modules/CommentsScreen/comments_shimmer.dart';
import 'package:my_social_app/modules/CommentsScreen/widgets/comment_box.dart';
import 'package:my_social_app/modules/CommentsScreen/widgets/comment_item.dart';
import '../../shared/constants/const.dart';

class Comments extends StatelessWidget {
  const Comments({required this.index, super.key});

  final int index;
  static TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () {
                commentController = TextEditingController();
                cubit.cancelComments(context, posts[index]!.postId!);
              },
            ),
          ),
          body: ConditionalBuilder(
            fallback: (context) => CommentsShimmer(
              index: index,
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      fallback: (context) => const Center(
                        child: Text('write the first comment'),
                      ),
                      condition: true,
                      builder: (context) => ListView.separated(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey[700],
                            height: 1,
                          ),
                        ),
                        itemBuilder: (context, index) => CommentItem(
                            commentModel: cubit.commentsPost[index]),
                        itemCount: cubit.commentsPost.length,
                      ),
                    ),
                  ),
                  CommentBox(index: index),
                ],
              ),
            ),
            condition: state is! GetCommentLoadingState,
          ),
        );
      },
    );
  }
}
