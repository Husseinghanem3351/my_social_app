import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/components.dart';
import '../../../shared/styles/icon_broken.dart';
import '../../../shared/widgets/default_button.dart';
import '../../../shared/widgets/extended_image.dart';
import '../cubit/cubit.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage(
      {super.key, required this.imageUrl, required this.profileImage});

  final String? imageUrl;
  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          height: 130,
          width: 130,
          child: DefaultButton(
            onTap: () {
              navigateTo(
                  context: context, screen: DefaultExtendedImage(url: imageUrl!));
            },
            buttonWidget: CircleAvatar(
              radius: 64,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!) as ImageProvider<Object>
                    : CachedNetworkImageProvider(imageUrl!),
              ),
            ),
          ),
        ),
        CircleAvatar(
          child: IconButton(
            onPressed: () {
              EditProfileCubit.get(context).getProfileImage();
            },
            icon: const Icon(IconBroken.Camera),
          ),
        )
      ],
    );
  }
}
