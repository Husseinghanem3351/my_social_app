import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_social_app/modules/add_and_edit_post/cubit/states.dart';
import 'package:my_social_app/modules/add_and_edit_post/widgets/add_images_and_tags.dart';
import 'package:my_social_app/shared/constPersonalInfo.dart';

import '../../../models/post_model.dart';
import '../../../shared/components.dart';
import '../../../shared/constants/const.dart';

class EditPostsCubit extends Cubit<EditPostsStates> {
  EditPostsCubit() : super(EditPostsInitState());

  static EditPostsCubit get(context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();

  PostModel? postModel;

  String? postImageUrl;

  File? postImage;

  Future<void> getPostImage(context) async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        postImage = File(value.path);
      }
      emit(GetImagePostSuccess());
    }).catchError((error) {
      showToast(msg: error.toString());
    });
  }

  Future<void> uploadPostWithImage(context,
      {required String? text, required File? image, List<String>? tags}) async {
    try {
      final uploadTask = await FirebaseStorage.instanceFor(
              bucket: bucket,)
          .ref()
          .child('posts/${Uri.file(image!.path).pathSegments.last}')
          .putFile(image);
      final uploadSnapshot = uploadTask;

      if (uploadSnapshot.state == TaskState.success) {
        postImageUrl = await uploadSnapshot.ref.getDownloadURL();

        postModel = PostModel(
          name: userModel!.name!,
          uid: uid,
          image: userModel!.image,
          dateTime: DateTime.now().toString(),
          text: text,
          postImage: postImageUrl,
          commentsLength: 0,
          likesLength: 0,
          tags: tags,
        );

        await FirebaseFirestore.instance
            .collection('posts')
            .add(postModel!.toJson())
            .then((value) {});
      } else {
        showToast(msg: 'upload task filed', color: Colors.red);
        emit(PostErrorState());
      }
    } catch (error) {
      showToast(msg: error.toString(), color: Colors.red);
      print(error.toString());
      emit(PostErrorState());
    }
  }

  Future<void> createPost(context, {String? text, List<String>? tags}) async {
    emit(PostLoadingState());
    try {
      if (postImage != null) {
        await uploadPostWithImage(
          context,
          text: text,
          image: postImage,
          tags: tags,
        );
      } else {
        postModel = PostModel(
          name: userModel!.name!,
          uid: uid,
          image: userModel!.image,
          dateTime: DateTime.now().toString(),
          text: text,
          commentsLength: 0,
          likesLength: 0,
          tags: tags,
        );
        await FirebaseFirestore.instance
            .collection('posts')
            .add(postModel!.toJson())
            .then((value) async {});
      }

      Navigator.pop(context);

      currentIndex = 0;

      emit(PostSuccessState());
    } catch (error) {
      emit(PostErrorState());

      showToast(msg: error.toString());
    }
  }

  void removePostImage() {
    postImage = null;
    postImageUrl = '';
    emit(RemoveImagePostSuccessState());
  }

  Future<void> editPost(context,
      {required PostModel post,
      String? text,
      String? postImageArg,
      List<String>? tags}) async {
    emit(PostLoadingState());
    try {
      post.tags = tags;
      if (post.text != text) {
        post.text = text;
      }
      if (postImageArg != null) {
        post.postImage = postImageArg;
      }
      if (postImage != null) {
        try {
          final uploadTask = FirebaseStorage.instanceFor(
            bucket: bucket,
          )
              .ref()
              .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
              .putFile(postImage!);

          final uploadSnapshot = await uploadTask;

          if (uploadSnapshot.state == TaskState.success) {
            postImageUrl = await uploadSnapshot.ref.getDownloadURL();

            postModel = PostModel(
              name: post.name,
              uid: post.uid,
              image: post.image,
              dateTime: post.dateTime,
              text: post.text,
              postImage: postImageUrl,
              commentsLength: post.commentsLength,
              likesLength: post.likesLength,
              tags: tags,
            );

            await FirebaseFirestore.instance
                .collection('posts')
                .doc(post.postId)
                .update(postModel!.toJson())
                .then((value) {});
          } else {
            showToast(msg: 'upload task filed', color: Colors.red);
            emit(PostErrorState());
          }
        } catch (error) {
          showToast(msg: error.toString(), color: Colors.red);
          emit(PostErrorState());
        }
      } else {
        print('post id${post.postId}');
        print(post.uid);
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(post.postId)
            .update(post.toJson());
      }
      Navigator.pop(context);

      currentIndex = 0;

      emit(EditPostSuccessState());
    } catch (error) {
      emit(PostErrorState());

      showToast(msg: error.toString());
    }
  }

  void addToTags(String tag) {
    AddImagesAndTags.tags.add(tag);
    AddImagesAndTags.tagsController=TextEditingController();
    emit(EditTagState());
  }

  void removeTag(int index) {
    AddImagesAndTags.tags.removeAt(index);
    emit(EditTagState());
  }
}
