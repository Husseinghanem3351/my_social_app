abstract class ChatStates {}

class InitChatState extends ChatStates {}

class GetUsersSuccessState extends ChatStates {}

class GetUsersLoadingState extends ChatStates {}

class GetUsersErrorState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class GetChatSuccessState extends ChatStates {}

class ShowMessageState extends ChatStates {}

class GetImageSuccessState extends ChatStates {}

class GetImageErrorState extends ChatStates {
  GetImageErrorState(this.error);
  String error;
}
class RemoveImageSuccessState extends ChatStates{}
