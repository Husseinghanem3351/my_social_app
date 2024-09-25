import 'package:flutter/material.dart';
import 'package:my_social_app/modules/add_and_edit_post/add_new_post.dart';
import 'package:my_social_app/modules/add_and_edit_post/edit_post_screen.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_images_and_tags.dart';
import '../../../shared/components.dart';
import '../../../shared/styles/icon_broken.dart';
import '../cubit/cubit.dart';

PreferredSizeWidget buildNewPostAppbar(
  BuildContext context, {
  required bool isCreate,
}) {
  var cubit = EditPostsCubit.get(context);
  return defaultAppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
        isCreate
            ? AddNewPost.postController = TextEditingController()
            : EditPostScreen.postController = TextEditingController();
        cubit.removePostImage();
      },
      icon: const Icon(IconBroken.Arrow___Left_2),
    ),
    context: context,
    title: isCreate ? 'Create Post' : 'Edit Post',
    actions: [
      TextButton(
        onPressed: () {
          isCreate
              ? cubit.createPost(
                  context,
                  text: AddNewPost.postController.text,
                  tags: AddImagesAndTags.tags,
                )
              : cubit.editPost(
                  context,
                  post: EditPostScreen.postModel!,
                  text: EditPostScreen.postController.text,
                  tags: AddImagesAndTags.tags,
                );
          AddNewPost.postController.clear();
          EditPostScreen.postController.clear();
        },
        child: Text(
          isCreate ? 'Post' : 'Edit',
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
