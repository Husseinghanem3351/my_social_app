abstract class EditProfileStates{}

class EditProfileInitState extends EditProfileStates{}



class GetImagePickerSuccessState extends EditProfileStates {}

class GetImagePickerErrorState extends EditProfileStates {}

class UploadProfileImageSuccessState extends EditProfileStates {}

class UploadProfileImageErrorState extends EditProfileStates {}

class UploadCoverImageSuccessState extends EditProfileStates {}

class UploadCoverImageErrorState extends EditProfileStates {}

class SocialUserUpdateErrorState extends EditProfileStates {}

class LoadingUpdateUserState extends EditProfileStates {}
