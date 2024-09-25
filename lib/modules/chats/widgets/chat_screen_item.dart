import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../shared/components.dart';
import '../chat_user.dart';
import '../cubit/cubit.dart';

class ChatScreenItem extends StatelessWidget {
  const ChatScreenItem({super.key,required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChatCubit.get(context).messages=[];
        return navigateTo(
          context: context,
          screen: ChatUser(user: user,),
        );},
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    user.image!
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 1,
                  end: 1,
                ),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


