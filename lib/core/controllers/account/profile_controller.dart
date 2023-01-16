import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/user_models/user.dart';
import '../../models/user_models/user_gender.dart';
import '../../services/api_account.dart';
import '../auth/auth_controller.dart';
import '../auth/profile_editing_controller.dart';

enum ProfileImageState {
  none,
  current,
  picker,
}

class ProfileController extends ProfileEditingController
    with ChangeNotifierHelpers {
  ProfileController(User? user)
      : _imageState = user?.imageUrl == null
            ? ProfileImageState.none
            : ProfileImageState.current;

  ImagePicker imagePicker = ImagePicker();
  File? pickedImage;

  ProfileImageState _imageState = ProfileImageState.picker;
  ProfileImageState get imageState => _imageState;
  set imageState(ProfileImageState value) {
    _imageState = value;
    notifyListeners();
  }

  Future<void> initialize(AuthController auth) async {
    User? data = await ApiAccount.getProfile();

    var imageUrl = data?.imageUrl;
    if (imageUrl == null) {
      imageState = ProfileImageState.none;
    } else {
      // clear cached network image cache
      await CachedNetworkImage.evictFromCache(imageUrl);
    }

    auth.user = data;
  }

  Future<void> pickImage() async {
    var picked = await imagePicker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      pickedImage = File(picked.path);
      imageState = ProfileImageState.picker;
    }
  }

  Future<User?> saveChanges(User? currentUser) async {
    if (isLoading) return null;
    isLoading = true;

    User user = User(
      id: currentUser?.id,
      first_name: firstName.isEmpty ? null : firstName,
      last_name: lastName.isEmpty ? null : lastName,
      email: email.isEmpty ? null : email,
      birthDate: birthDate.isEmpty ? null : birthDate,
      gender: (selectedGender ?? UserGender.m).name,
      city: selectedCity,
      job: job.isEmpty ? null : job,
    );

    User? result;
    try {
      bool removeImage = imageState == ProfileImageState.none;
      result = await ApiAccount.updateProfile(user, pickedImage, removeImage);
    } catch (e) {
      //
    }

    if (result?.imageUrl == null) imageState = ProfileImageState.none;

    isLoading = false;
    return result;
  }
}
