import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/modules/feeds/widgets/post_item.dart';
import '../../../HomeLayout/cubit/states.dart';
import '../../shared/constants/const.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // SocialCubit.get(context).getPosts(context);
        return RefreshIndicator(
          onRefresh: () {
            return SocialCubit.get(context).getPosts(context);
          },
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) => PostItem(
                post: posts[index]!,
                index: index,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget testItem(){
//   return Card(
//     margin: EdgeInsets.zero,
//     color: Colors.white,
//     child: Container(
//       width: double.infinity,
//       height: 200,
//     ),
//   );
// }
