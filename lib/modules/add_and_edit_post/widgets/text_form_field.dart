import 'package:flutter/material.dart';
import 'package:my_social_app/modules/add_and_edit_post/add_new_post.dart';
import 'package:my_social_app/modules/add_and_edit_post/edit_post_screen.dart';

class EditTextFromField extends StatelessWidget {
  const EditTextFromField({
    super.key,
    required this.isEdit,
  });

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextFormField(
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'what is on your mind',
          hintStyle: Theme.of(context).textTheme.bodySmall,
          border: InputBorder.none,

        ),
        controller:
            isEdit ? EditPostScreen.postController : AddNewPost.postController,
      ),
    );
  }
}
