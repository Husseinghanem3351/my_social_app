import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_social_app/HomeLayout/cubit/states.dart';
import 'package:my_social_app/shared/components.dart';
import 'package:my_social_app/models/user_model.dart';
import 'package:my_social_app/models/post_model.dart';
import 'package:my_social_app/modules/Login/login.dart';
import '../../models/comment_model.dart';
import '../../modules/CommentsScreen/comments.dart';
import '../../modules/profile/profile.dart';
import '../../shared/Network/local/cache_helper.dart';
import '../../shared/constants/const.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  void getUser(
    context,
    String userUid,
  ) {
    //global
    emit(SocialGetUserLoadingState());
    if (uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .snapshots()
          .listen((value) {
        userModel = UserModel.fromJson(value.data());
        emit(SocialGetUserSuccessState());
      });
    }
  }

  void changeBottomNavBar(int index, context) {
    // home
    if (index == 2) {
      emit(AddNewPostScreenState(context));
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  Map<String, Map<String, bool?>> postsLikes = {};

  Future<void> likePost(int index) async {
    try {
      if (postsLikes[posts[index]?.postId]?[uid] == null) {
        postsLikes[posts[index]?.postId]?[uid!] = true;
        await Future.sync(
          () => posts[index]?.likesLength++,
        );
        emit(LikePostSuccessState());
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(posts[index]?.postId)
            .collection('likes')
            .doc(uid)
            .set({'like': true});
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(posts[index]?.postId)
            .update({
          'likesLength': posts[index]?.likesLength,
        });
      } else {
        postsLikes[posts[index]?.postId]?.remove(uid);
        await Future.sync(
          () => posts[index]?.likesLength--,
        );
        emit(LikePostSuccessState());
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(posts[index]?.postId)
            .collection('likes')
            .doc(uid)
            .delete();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(posts[index]?.postId)
            .update({
          'likesLength': posts[index]?.likesLength,
        });
      }
    } catch (error) {
      if (postsLikes[posts[index]?.postId]?[uid] == null) {
        postsLikes[posts[index]?.postId]?.addAll({uid!: true});
        posts[index]!.likesLength--;
      } else {
        postsLikes[posts[index]?.postId]?.remove(uid);
        posts[index]!.likesLength++;
      }
      showToast(msg: error.toString(), color: Colors.red);
      emit(LikePostErrorState());
    }
  }

  Future<void> writeComment(String comment, int index, String id) async {
    Comments.commentController = TextEditingController();
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('comments')
        .add({
      '${userModel!.uid}': comment,
      'dateTime': DateTime.now().toString(),
    }).then((value) async {
      // comments[index] += 1;
      await Future.sync(
        () => posts[index]!.commentsLength += 1,
      );
      FirebaseFirestore.instance
          .collection('posts')
          .doc(id)
          .update({'commentsLength': posts[index]!.commentsLength});
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<CommentModel> commentsPost = [];

  void cancelComments(context, String id) async {
    await commentsRef.cancel();
    Navigator.pop(context);
  }

  dynamic commentsRef;

  void getComments(int index) async {
    commentsPost.clear();
    commentsRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(posts[index]?.postId)
        .collection('comments')
        .snapshots()
        .listen((event) async {
      for (var element in event.docChanges) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(element.doc.data()!.keys.last)
            .get()
            .then((value) {
          commentsPost.insert(
            0,
            CommentModel(
                comment: element.doc.data()!.values.last,
                name: value.data()!['name'],
                image: value.data()!['image'],
                uid: element.doc.data()!.keys.last),
          );
        });
        if (commentsPost.length == 5) {
          emit(GetCommentSuccessState());
        }
      }
      emit(GetCommentSuccessState());
    });
    emit(GetCommentLoadingState());
    commentsRef;
  }

  void signOut(context) {
    CacheHelper.removeData('token');
    pushAndReplacement(context: context, screen: const Login());
    emit(SocialSignOutState());
  }

  List<UserModel> likesUsers = [];

  Future<void> usersLikes(int index) async {
    likesUsers = [];
    if (posts[index]?.likesLength != 0) {
      emit(GetLikesLoadingState());
      postsLikes[posts[index]?.postId]?.forEach((key, value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(key)
            .get()
            .then((value) {
          likesUsers.add(UserModel.fromJson(value.data()));
          emit(GetLikesSuccessState());
        });
      });
    }
  }

  List<PostModel> profilePosts = [];

  void getProfilePosts(String userUid) {
    profilePosts = [];
    for (var element in posts) {
      if (element?.uid == userUid) {
        profilePosts.add(element!);
      }
    }
  }

  UserModel? userProfile;

  void openProfile(String userUid, context) async {
    emit(GetProfileUserLoadingState());
    getProfilePosts(userUid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((value) {
      userProfile = UserModel.fromJson(value.data());
    });
    emit(GetProfileUserSuccessState());
    navigateTo(
        context: context,
        screen: Profile(
          user: userProfile!,
        ));
  }

  List<PostModel> searchPosts = [];

  void search({required String text}) {
    searchPosts = [];
    emit(SearchPostsLoadingState());
    for (var element in posts) {
      if (element!.text!.contains(text)) {
        searchPosts.add(element);
      }
    }
    emit(SearchPostsSuccessState());
  }

  Future<void> deletePost(String postId, context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('are you sure you want to delete this post'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .delete()
                      .then(
                    (value) {
                      emit(RemovePostSuccessState());
                    },
                  ).catchError((error) {
                    emit(RemovePostErrorState(error.toString()));
                  });
                },
                child: const Text('yes')),
          ],
        );
      },
    );
  }

  Future<void> getPosts(context) async {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen(
      (value) async {
        List<PostModel?> newPosts = [];
        Map<String, Map<String, bool?>> newPostsLikes = {};
        int i = 0;
        for (var post in value.docs) {
          await Future.sync(
            () {
              newPosts.add(PostModel.fromJson(post.data()));
            },
          );
          if (newPosts[i]?.postId == null) {
            newPosts[i]?.postId = post.id;
            await FirebaseFirestore.instance
                .collection('posts')
                .doc(post.id)
                .update(
              {
                'postId': post.id,
              },
            );
          }
          await post.reference.collection('likes').get().then(
            (value) {
              newPostsLikes.addAll({post.id: {}});
              newPosts[i]?.likesLength = value.docs.length;
              for (var like in value.docs) {
                newPostsLikes[post.id]?.addAll({like.id: like.data()['like']});
              }
            },
          ).catchError(
            (error) {
              showToast(msg: error.toString(), color: Colors.red);
            },
          );
          i++;
        }
        postsLikes = newPostsLikes;
        posts = newPosts;
        emit(GetPostsSuccessState());
      },
    );
  }

  List<PostModel> getTagPosts(String tag){
    List<PostModel> tagPosts=[];
    for(int i=0;i<posts.length;i++){
      if(posts[i]?.tags!=null&&posts[i]!.tags!.contains(tag)) {
        tagPosts.add(posts[i]!);
      }
    }
    return tagPosts;
  }
}
