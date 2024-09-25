import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/models/user_model.dart';
import 'package:my_social_app/modules/add_and_edit_post/cubit/cubit.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_images_and_tags.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_new_post_app_bar.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/post_image.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/text_form_field.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/user_details.dart';
import '../../shared/constants/const.dart';
import 'cubit/states.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({super.key});

  static TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPostsCubit, EditPostsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? user = userModel;
        var cubit = EditPostsCubit.get(context);
        return Scaffold(
          appBar: buildNewPostAppbar(
            context,
            isCreate: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is PostLoadingState)
                    const LinearProgressIndicator(),
                  UserDetails(user: user),
                  const Expanded(
                    child: EditTextFromField(
                      isEdit: false,
                    ),
                  ),
                  if (cubit.postImage != null)
                    const Expanded(child: PostImage()),
                  const AddImagesAndTags(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
