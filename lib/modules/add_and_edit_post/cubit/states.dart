
abstract class EditPostsStates {}

class EditPostsInitState extends EditPostsStates{}


class PostLoadingState extends EditPostsStates {}

class PostErrorState extends EditPostsStates {}

class PostSuccessState extends EditPostsStates {}

class EditPostSuccessState extends EditPostsStates {}

class GetImagePostSuccess extends EditPostsStates {}

class RemoveImagePostSuccessState extends EditPostsStates {}
class EditTagState extends EditPostsStates {}
