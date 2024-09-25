import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_social_app/modules/chats/cubit/states.dart';
import 'package:my_social_app/shared/constPersonalInfo.dart';
import '../../../models/Message_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/constants/const.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitChatState());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void removeImage() {
    imageFile = null;
    emit(RemoveImageSuccessState());
  }

  Future<File?> getImage(context) async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
      }
      emit((GetImageSuccessState()));
    }).catchError((error) {
      emit(GetImageErrorState(error.toString()));
      return null;
    });
    return null;
  }

  Future<String?> uploadImage(File image) async {
    final uploadTask = await FirebaseStorage.instanceFor(
      bucket: bucket,
    )
        .ref()
        .child('posts/${Uri.file(image.path).pathSegments.last}')
        .putFile(image);
    final uploadSnapshot = uploadTask;

    if (uploadSnapshot.state == TaskState.success) {
      return await uploadSnapshot.ref.getDownloadURL();
    } else {
      print('error in upload');
    }
    return null;
  }


  void showMessage(int id) {
    // chat screen
    if (showMessageId != id) {
      showMessageId = id;
    } else {
      showMessageId = null;
    }
    emit(ShowMessageState());
  }

  void getUsers(context) {
    users = [];
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uid'] != userModel!.uid) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetUsersSuccessState());
    });
  }

  Future<void> sendMessage({
    String? text,
    required String receiverUid,
    File? image,
  }) async {
    String? imageUrl;
    if (image != null) {
      print(image.uri);
      imageUrl = await uploadImage(image);
    }
    var timestamp = Timestamp.now();
    MessageModel messageModelSender = MessageModel(
      receiverUid: receiverUid,
      senderUid: userModel!.uid,
      text: text,
      dateTime: timestamp,
      messageImage: imageUrl,
    );

    MessageModel messageModelReceiver = MessageModel(
      receiverUid: receiverUid,
      senderUid: userModel!.uid,
      text: text,
      messageImage: imageUrl,
    );

    imageUrl = null;
    saveReceiverMessage(messageModelReceiver);

    saveSenderMessage(messageModelSender);
  }

  void saveSenderMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(message.receiverUid)
        .collection('messages')
        .add(message.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      saveSenderMessage(message);
    });
  }

  void saveReceiverMessage(MessageModel message) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(message.receiverUid)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(message.toJson())
        .then((value) {})
        .catchError((error) {
      saveReceiverMessage(message);
    });
  }

  List<MessageModel> messages = [];

  void getMessages(String receiverUid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid!)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) async {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
        if (messages.last.dateTime == null) {
          messages.last.dateTime = Timestamp.now();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uid!)
              .collection('chats')
              .doc(receiverUid)
              .collection('messages')
              .doc(element.id)
              .update({'dateTime': Timestamp.now()});
        }
      }
      emit(GetChatSuccessState());
    });
  }
}
