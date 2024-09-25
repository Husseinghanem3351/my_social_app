import 'package:flutter/material.dart';
import 'package:my_social_app/modules/chats/cubit/cubit.dart';

import '../../../shared/styles/icon_broken.dart';

class SendingImage extends StatelessWidget {
  const SendingImage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatCubit cubit=ChatCubit.get(context);
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image(
          width: double.infinity,
          height: 100,
          image: FileImage(
            cubit.imageFile!,
          ),
          fit: BoxFit.contain,
        ),
        IconButton(
          onPressed: () {
            cubit.removeImage();
          },
          icon: const Icon(IconBroken.Close_Square),
        ),
      ],
    );
  }
}
