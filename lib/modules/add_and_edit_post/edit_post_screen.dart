import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/models/user_model.dart';
import 'package:my_social_app/modules/add_and_edit_post/cubit/cubit.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_images_and_tags.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_new_post_app_bar.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/edit_post_image.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/text_form_field.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/user_details.dart';
import '../../models/post_model.dart';
import '../../shared/constants/const.dart';
import 'cubit/states.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({super.key, required this.post});

  final PostModel post;
  static PostModel? postModel;

  static TextEditingController postController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    postController = TextEditingController(text: post.text);
    postModel = post;
    String? postImage = post.postImage;
    return BlocConsumer<EditPostsCubit, EditPostsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? user = userModel;
        var cubit = EditPostsCubit.get(context);
        return Scaffold(
          appBar: buildNewPostAppbar(context, isCreate: false),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is PostLoadingState) const LinearProgressIndicator(),
                UserDetails(user: user),
                const Expanded(
                  child: EditTextFromField(
                    isEdit: true,
                  ),
                ),
                if (postImage != null || cubit.postImage != null)
                  EditPostImage(
                    cubitImage: cubit.postImage,
                    postImage: postImage,
                    function: () {
                      cubit.postImage = null;
                      cubit.removePostImage();
                    },
                  ),
                const AddImagesAndTags(),
              ],
            ),
          ),
        );
      },
    );
  }
}
