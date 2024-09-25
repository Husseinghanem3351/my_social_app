import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/shared/components.dart';
import 'package:my_social_app/shared/widgets/default_button.dart';
import 'package:my_social_app/shared/widgets/extended_image.dart';

import '../../../shared/styles/icon_broken.dart';
import '../cubit/cubit.dart';

class UserCoverImage extends StatelessWidget {
  const UserCoverImage({super.key, this.imageUrl, this.coverImage});

  final String? imageUrl;
  final File? coverImage;
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: 140,
              child: DefaultButton(
                onTap: () {
                  navigateTo(context: context, screen: DefaultExtendedImage(url: imageUrl!));
                },
                buttonWidget: Container(
                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: coverImage!=null
                            ?FileImage(coverImage!) as ImageProvider<Object>
                            : CachedNetworkImageProvider(imageUrl!),
                        fit: BoxFit.cover,)
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
              radius: 20,
              child: IconButton(
                  onPressed: (){
                    EditProfileCubit.get(context).getCoverImage(context);
                  },
                  icon: const Icon(IconBroken.Camera))
          ),
        ],
      );
  }
}
