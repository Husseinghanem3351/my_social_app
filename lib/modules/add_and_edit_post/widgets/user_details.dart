import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key,required this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(user!.image!),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user!.name!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 5,),
            Text(
              'public',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
