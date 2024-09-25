import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_social_app/modules/Edit_Profile/cubit/states.dart';
import 'package:my_social_app/shared/constPersonalInfo.dart';

import '../../../shared/components.dart';
import '../../../shared/constants/const.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitState());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  File? profileImage;

  ImagePicker picker = ImagePicker();

  Future<XFile?> getImageGallery() async {
    try {
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      emit(GetImagePickerSuccessState());
      return image;
    } catch (error) {
      emit(GetImagePickerErrorState());
    }
    return null;
  }

  Future<void> getProfileImage() async {
    getImageGallery().then((value) {
      if (value != null) {
        profileImage = File(value.path);
      }
    });
  }

  File? coverImage;

  Future<void> getCoverImage(context) async {
    getImageGallery().then((value) {
      if (value != null) {
        coverImage = File(value.path);
      }
    });
  }

  String? profileImageUrl;

  Future<void> uploadProfileImage(context) async {
    FirebaseStorage.instanceFor(bucket: bucket)
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      print('ref profile image $value');
      await value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update({
          'image': profileImageUrl,
        }).then((value) {
          for (var element in posts) {
            if (element!.uid == userModel!.uid) {
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc(element.postId)
                  .update({
                'image': profileImageUrl,
              });
            }
          }
          profileImage = null;
        });
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
        showToast(msg: error.toString(), color: Colors.red);
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      showToast(msg: error.toString());
    });
  }

  String? coverImageUrl;

  Future<void> uploadCoverImage(context) async {
    FirebaseStorage.instanceFor(bucket: bucket)
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) async {
      print('success upload image');
      await value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uid)
            .update({
          'cover': coverImageUrl,
        }).then((value) {
          coverImage = null;
        });
      }).catchError((error) {
        showToast(msg: error.toString());
      });
    }).catchError((error) {
      showToast(msg: error.toString());
    });
  }

  void updateUser(
      context, {
        required String name,
        required String bio,
        required String phone,
      }) async {
    emit(LoadingUpdateUserState());
    if (profileImage != null) {
      print('profile Image Not null');
      uploadProfileImage(context);
    }
    if (coverImage != null) {
      print('cover Image Not null');
      uploadCoverImage(context);
    }
    FirebaseFirestore.instance.collection('users').doc(userModel!.uid).update({
      'name': name,
      'bio': bio,
      'phone': phone,
    }).then((value) {
      for (var element in posts) {
        if (element!.uid == userModel!.uid) {
          FirebaseFirestore.instance
              .collection('posts')
              .doc(element.postId)
              .update({
            'name': name,
          });
        }
      }

      showToast(msg: 'updated successfully', color: Colors.green);
    }).catchError((error) {
      showToast(msg: error.toString(), color: Colors.red);
      emit(SocialUserUpdateErrorState());
    });
  }

}
