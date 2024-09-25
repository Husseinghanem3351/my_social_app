import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/modules/chats/widgets/chat_screen_item.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ChatCubit.get(context).getUsers(context);
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ChatScreenItem(
                      user: ChatCubit.get(context).users[index],
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: ChatCubit.get(context).users.length,
                  ),
                )
              ],
            ),
          ),
          condition: state is! GetUsersLoadingState,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
