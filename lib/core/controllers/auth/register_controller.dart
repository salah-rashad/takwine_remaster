import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/user_models/user.dart';
import '../../models/user_models/user_gender.dart';
import '../../services/api_auth.dart';
import 'profile_editing_controller.dart';

class RegisterController extends ProfileEditingController
    with ChangeNotifierHelpers {
  Future<bool> createAccount() async {
    if (isLoading) return false;
    isLoading = true;

    User user = User(
      first_name: firstName,
      last_name: lastName,
      email: email,
      birthDate: birthDate,
      gender: (selectedGender ?? UserGender.m).name,
      city: selectedCity,
      job: job,
    );

    var result = false;
    try {
      result = await ApiAuth.createAccount(user, password);
    } catch (e) {
      result = false;
    }

    isLoading = false;
    return result;
  }
}
