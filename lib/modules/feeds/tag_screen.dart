import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/modules/feeds/widgets/post_item.dart';

import '../../HomeLayout/cubit/cubit.dart';
import '../../HomeLayout/cubit/states.dart';
import '../../models/post_model.dart';

class TagPostsScreen extends StatelessWidget {
  const TagPostsScreen({
    super.key,
    required this.posts,
  });

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // SocialCubit.get(context).getPosts(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) => PostItem(
                post: posts[index],
                index: index,
              ),
            ),
          ),
        );
      },
    );
  }
}
