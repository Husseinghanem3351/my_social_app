import 'dart:convert';

class PostModel{
  String? postId;
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  int commentsLength=0;
  int likesLength=0;
  List<String>? tags;

  PostModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.dateTime,
    this.postImage,
    this.text,
    required this.commentsLength,
    required this.likesLength,
    this.tags,
  });

  PostModel.fromJson(Map<String,dynamic>? json)
  {
    image=json?['image'];
    name=json?['name'];
    uid=json?['uid'];
    dateTime=json?['dateTime'];
    postImage=json?['postImage'];
    text=json?['text'];
    commentsLength=json?['commentsLength'];
    likesLength=json?['likesLength'];
    postId=json?['postId'];
    tags=json?['tags']!=null?mapToList(jsonDecode(json?['tags'])):[];
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'uid':uid,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,
      'text':text,
      'commentsLength':commentsLength,
      'likesLength':likesLength,
      'tags':tags!=null?jsonEncode(listToMap(tags!)):null,
    };
  }
}

List<String> stringToList(String stringElement){
  List<String> list=[];
  for(int i=0;i<stringElement.length;i++){
    if(stringElement[i]=='\''){
      String temp='';
      i++;
      while(stringElement[i]!='\''){
        temp+=stringElement[i];
        i++;
      }
      list.add(temp);
      stringElement=stringElement.substring(i+1);
      i=0;
    }
  }
  return list;
}
// {}
Map<String,String> listToMap(List list){
  Map<String,String> map={};
  for (int i=0;i<list.length;i++){
    map.addAll({'$i':list[i]});
  }
  return map;
}

List<String> mapToList(Map map){
  List<String> list=[];
  map.forEach((key, value) {
    list.add(value);
  },);
  return list;
}