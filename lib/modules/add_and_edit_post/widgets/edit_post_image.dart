import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/modules/add_and_edit_post/cubit/cubit.dart';

class EditPostImage extends StatelessWidget {
  const EditPostImage({super.key, this.cubitImage, this.postImage, this.function});

  final void Function()? function;
  final File? cubitImage;
  final String? postImage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          cubitImage != null
              ? Image(
            image: FileImage(
              cubitImage!,
            ),
            fit: BoxFit.cover,
          )
              : Image(
              image: CachedNetworkImageProvider(postImage!)),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: function,
            icon: const Icon(Icons.close),
            style: const ButtonStyle(
              iconColor: WidgetStatePropertyAll(Colors.black),
            ),
          ),
        ],
      ),);
  }
}
