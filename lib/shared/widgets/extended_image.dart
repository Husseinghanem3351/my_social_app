import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:my_social_app/modules/feeds/widgets/view_reaction_and_comments.dart';
import 'package:my_social_app/modules/feeds/widgets/write_comment_and_reaction.dart';
import 'package:my_social_app/shared/components.dart';
import '../../models/post_model.dart';

class DefaultExtendedImage extends StatelessWidget {
  const DefaultExtendedImage({
    super.key,
    this.post,
    this.index,
     this.url,
     this.file,
  });

  final PostModel? post;
  final int? index;
  final String? url;
  final File? file;

  @override
  Widget build(BuildContext context) {
    if(file==null&&url==null) throw 'one of this arguments should not be null url and file ' ;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child:url!=null? ExtendedImage.network(
                width: double.infinity,
                url!,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
                enableMemoryCache: true,
                // width: double.infinity,
                fit: BoxFit.fill,
                cache: true,
                border: Border.all(color: Colors.white, width: 1.0),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                //cancelToken: cancellationToken,
              ): ExtendedImage(image: FileImage(file!)),
            ),
            if (post != null) ...[
              ViewReactionAndComments(index: index!, post: post!),
              const MyDivider(
                bottomPadding: 0,
              ),
              WriteCommentAndReaction(index: index!, post: post!),
            ]
          ],
        ),
      ),
    );
  }
}
