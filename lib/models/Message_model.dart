import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? receiverUid;
  String? senderUid;
  String? text;
  Timestamp? dateTime;
  String? messageImage;

  MessageModel({
    required this.receiverUid,
    required this.senderUid,
     this.text,
     this.dateTime,
    this.messageImage
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    receiverUid=json['receiverUid'];
    senderUid=json['senderUid'];
    text=json['text'];
    dateTime=json['dateTime'];
    messageImage=json['image'];
  }

  Map<String,dynamic> toJson(){
    return {
      'receiverUid':receiverUid,
      'senderUid':senderUid,
      'text':text,
      'dateTime':dateTime,
      'image':messageImage,
    };
  }

}

