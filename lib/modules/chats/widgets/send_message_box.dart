import 'package:flutter/material.dart';
import 'package:my_social_app/modules/chats/cubit/cubit.dart';

import '../../../models/user_model.dart';
import '../chat_user.dart';

class SendMessageBox extends StatelessWidget {
  const SendMessageBox({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
   ChatCubit cubit=ChatCubit.get(context);
    return Container(
      padding:
      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const Border.fromBorderSide(
            BorderSide(color: Colors.blueGrey)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              await cubit.getImage(context);
            },
            icon: const Icon(
              Icons.image,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: ChatUser.messageController,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'type message',
                suffixIcon: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    ChatCubit.get(context).sendMessage(
                      text: ChatUser.messageController.text,
                      receiverUid: user.uid!,
                      image: cubit.imageFile,
                    );
                    cubit.removeImage();
                    ChatUser.messageController.clear();
                  },
                  icon: const Icon(Icons.chevron_right_sharp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
