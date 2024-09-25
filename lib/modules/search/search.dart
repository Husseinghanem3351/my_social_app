import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import '../../HomeLayout/cubit/states.dart';
import '../feeds/widgets/post_item.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'search',
                    ),
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      SocialCubit.get(context).search(text: value);
                    },
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => PostItem(
                      post: SocialCubit.get(context).searchPosts[index],
                      index: index,
                    ),
                    itemCount: SocialCubit.get(context).searchPosts.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
