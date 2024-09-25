import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/modules/Edit_Profile/cubit/cubit.dart';
import 'package:my_social_app/modules/Edit_Profile/widgets/edit_bio_box.dart';
import 'package:my_social_app/modules/Edit_Profile/widgets/edit_name_box.dart';
import 'package:my_social_app/modules/Edit_Profile/widgets/edit_phone_box.dart';
import 'package:my_social_app/modules/Edit_Profile/widgets/user_cover_image.dart';
import 'package:my_social_app/modules/Edit_Profile/widgets/user_profile_image.dart';
import 'package:my_social_app/shared/components.dart';
import '../../models/user_model.dart';
import '../../shared/constants/const.dart';
import 'cubit/states.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  static TextEditingController nameController=TextEditingController();
  static TextEditingController bioController=TextEditingController();
  static TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var formKey=GlobalKey<FormState>();
        UserModel? user =userModel;
        var profileImage=EditProfileCubit.get(context).profileImage;
        var coverImage=EditProfileCubit.get(context).coverImage;
        nameController.text=user!.name!;
        bioController.text=user.bio!;
        phoneController.text=user.phone!;
        return Scaffold(
          appBar: defaultAppBar(
              actions: [
                TextButton(
                  onPressed: () {
                  if(formKey.currentState!.validate())  {
                  EditProfileCubit.get(context).updateUser(
                    context,
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                }
              },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 10,),
              ],
              context: context,
              title: 'Edit Profile'
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                   if(state is LoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 190,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            UserCoverImage(imageUrl: user.cover,coverImage: coverImage,),
                            UserProfileImage(imageUrl: user.image, profileImage: profileImage),
                          ]
                      ),
                    ),
                    const SizedBox(height: 20,),
                     const EditNameBox(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: EditBioBox(),
                    ),
                    const EditPhoneBox(),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
