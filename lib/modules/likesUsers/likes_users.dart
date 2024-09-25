import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/shared/components.dart';
import '../../HomeLayout/cubit/states.dart';
import 'like_user_item.dart';

class LikeUsers extends StatelessWidget {
  const LikeUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ConditionalBuilder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => UserItem(
                        user: SocialCubit.get(context).likesUsers[index],
                      ),
                      separatorBuilder: (context, index) => const MyDivider(),
                      itemCount: SocialCubit.get(context).likesUsers.length,
                    ),
                  )
                ],
              ),
            ),
            condition: state is! GetLikesLoadingState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
