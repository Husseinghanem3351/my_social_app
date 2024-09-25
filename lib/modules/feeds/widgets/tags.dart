import 'package:flutter/material.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/modules/feeds/tag_screen.dart';
import 'package:my_social_app/shared/components.dart';
import '../../../models/post_model.dart';

class Tags extends StatelessWidget {
  const Tags({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          children: List.generate(
            postModel.tags!.length,
            (index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 6),
                child: SizedBox(
                  height: 35,
                  child: MaterialButton(
                    onPressed: () {
                      navigateTo(
                          context: context,
                          screen: TagPostsScreen(
                              posts: SocialCubit.get(context)
                                  .getTagPosts(postModel.tags![index])));
                    },
                    padding: const EdgeInsets.all(9),
                    minWidth: 1,
                    child: Text(
                      '#${postModel.tags![index]}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
