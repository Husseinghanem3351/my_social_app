import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/modules/chats/widgets/message.dart';
import 'package:my_social_app/modules/chats/widgets/send_message_box.dart';
import 'package:my_social_app/modules/chats/widgets/sending_image.dart';
import 'package:my_social_app/shared/styles/icon_broken.dart';
import '../../models/user_model.dart';
import '../../shared/components.dart';
import '../../shared/constants/const.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChatUser extends StatelessWidget {
  const ChatUser({required this.user, super.key});

  final UserModel user;
  static TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);
    cubit.getMessages(user.uid!);

    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {
        if (state is GetImageErrorState) {
          showToast(msg: state.error.toString(), color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                cubit.imageFile = null;
                Navigator.of(context).pop(false);
              },
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user.image!),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('${user.name}'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      reverse: true,
                      itemBuilder: (context, index) {
                        if (cubit.messages[index].senderUid ==
                            userModel!.uid!) {
                          return Message(
                            index: index,
                            isSendingMessage: true,
                            message: cubit.messages[index],
                          );
                        }
                        return Message(
                          index: index,
                          isSendingMessage: false,
                          message: cubit.messages[index],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.messages.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.imageFile != null) const SendingImage(),
                SendMessageBox(user: user),
              ],
            ),
          ),
        );
      },
    );
  }
}
