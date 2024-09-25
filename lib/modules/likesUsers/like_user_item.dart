import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../HomeLayout/cubit/cubit.dart';
import '../../models/user_model.dart';
import '../../shared/styles/icon_broken.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SocialCubit.get(context).openProfile(user.uid!, context);
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                    user.image!
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 1,
                  end: 1,
                ),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
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
          ),
          const Icon(IconBroken.Heart,color: Colors.red,),
        ],
      ),
    );
  }
}

