import 'package:my_social_app/shared/components.dart';

import '../../modules/add_and_edit_post/add_new_post.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {}

class ChangeBottomNavBarState extends SocialStates {}

class GetProfileUserSuccessState extends SocialStates{}

class GetProfileUserLoadingState extends SocialStates{}


class ShowMessageState extends SocialStates{}

//posts
class AddNewPostScreenState extends SocialStates {
  AddNewPostScreenState(context) {
    navigateTo(context: context, screen: const AddNewPost());
  }

}

class GetPostsLoadingState extends SocialStates {}

class GetPostsErrorState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class LikePostLoadingState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {}

class CommentSuccessState extends SocialStates {}

class CommentErrorState extends SocialStates {}

class GetCommentLoadingState extends SocialStates {}

class GetCommentSuccessState extends SocialStates {}

class GetCommentErrorState extends SocialStates {}

class RemovePostLoadingState extends SocialStates {}

class RemovePostSuccessState extends SocialStates {}

class RemovePostErrorState extends SocialStates {
  RemovePostErrorState(this.error);
  String error;
}

class ChangeSnackBarState extends SocialStates {}



class SocialSignOutState extends SocialStates{}

class GetLikesSuccessState extends SocialStates {}

class GetLikesLoadingState extends SocialStates{}

class ChangeTextPostState extends SocialStates{}

class SearchPostsSuccessState extends SocialStates{}
class SearchPostsLoadingState extends SocialStates{}


