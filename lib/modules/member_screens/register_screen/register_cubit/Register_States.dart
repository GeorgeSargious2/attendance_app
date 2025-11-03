abstract class registerStates {}

class registerInitialState extends registerStates {}

class registerSuccessState extends registerStates {}

class registerLoadingState extends registerStates {}

class registerErrorState extends registerStates {
  final String error;

  registerErrorState(this.error);
}

class registerPassIconState extends registerStates {}

class createUserSuccessState extends registerStates {}

class createUserErrorState extends registerStates {
  final String error;

  createUserErrorState(this.error);
}

// image picker states
class imageCameraPickerState extends registerStates {}

class imageGalleryPickerState extends registerStates {}

class imageUploadErrorState extends registerStates {
  final String error;

  imageUploadErrorState(this.error);
}
