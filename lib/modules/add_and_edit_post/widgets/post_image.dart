import 'package:flutter/material.dart';
import 'package:my_social_app/shared/components.dart';
import 'package:my_social_app/shared/styles/icon_broken.dart';
import 'package:my_social_app/shared/widgets/default_button.dart';
import 'package:my_social_app/shared/widgets/extended_image.dart';

import '../cubit/cubit.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=EditPostsCubit.get(context);
    return  Center(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          DefaultButton(
            onTap: (){
              navigateTo(context: context, screen: DefaultExtendedImage(file: cubit.postImage,));
            },
            buttonWidget: Image(
              image: FileImage(
                cubit.postImage!,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              cubit.removePostImage();
            },
            icon: const Icon(IconBroken.Close_Square,),
            style: const ButtonStyle(
                iconColor: WidgetStatePropertyAll(Colors.black)
            ),
          ),
        ],
      ),
    );
  }
}
