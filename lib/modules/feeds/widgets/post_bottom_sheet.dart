import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_social_app/HomeLayout/cubit/cubit.dart';
import 'package:my_social_app/models/post_model.dart';
import 'package:my_social_app/modules/add_and_edit_post/edit_post_screen.dart';
import 'package:my_social_app/shared/components.dart';
import 'package:my_social_app/shared/constants/const.dart';

void postBottomSheet(context, PostModel post) => showModalBottomSheet(
      backgroundColor: HexColor('#090B0B'),
      enableDrag: true,
      sheetAnimationStyle: AnimationStyle(duration: const Duration(seconds: 1)),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(post.uid==userModel?.uid)
              ...[postBottomSheetItem(
                text: 'delete post',
                pressFunction: () {
                  Navigator.pop(context);
                  SocialCubit.get(context).deletePost(post.postId!, context);
                },
              ),
              postBottomSheetItem(
                text: 'edit post',
                pressFunction: () {
                  Navigator.pop(context);
                  navigateTo(
                    context: context,
                    screen: EditPostScreen(
                      post: post,
                    ),
                  );
                },
              ),],
              postBottomSheetItem(
                text: 'share post',
                pressFunction: () {},
              )
            ],
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
      ),
    );

Widget postBottomSheetItem(
    {required String text, required void Function()? pressFunction}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: pressFunction,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HexColor('#343232').withOpacity(.5),
        ),
        child: Center(child: Text(text)),
      ),
    ),
  );
}
