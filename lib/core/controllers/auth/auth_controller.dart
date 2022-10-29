import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../ui/widgets/dialogs/general_dialog.dart';
import '../../helpers/enums/auth_status_enum.dart';
import '../../helpers/utils/cache_manager.dart';
import '../../helpers/utils/change_notifier_state_logger.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/user_models/user.dart';
import '../../services/api_provider.dart';

class AuthController extends ChangeNotifier with ChangeNotifierStateLogger {
  AuthController() {
    initialize();
  }

  User? user;
  Enrollment? lastActivity;

  AuthStatus _status = AuthStatus.LOGGED_OUT;

  AuthStatus get status => _status;
  set status(AuthStatus value) {
    _status = value;
    notifyListeners();
  }

  bool get isLoggedIn => status == AuthStatus.LOGGED_IN;

  Future<void> initialize() async {
    var fullToken = CacheManager.getFullToken();
    if (fullToken != null) {
      try {
        bool isTokenExpired = JwtDecoder.isExpired(fullToken);
        if (!isTokenExpired) status = AuthStatus.LOGGED_IN;
      } catch (e) {
        if (kDebugMode) {
          print("Error token: $fullToken");
          print(e);
        }
      }
    }

    var user = await ApiProvider().account.getProfile();

    if (user != null) {
      status = AuthStatus.LOGGED_IN;
    }
  }

  Future<bool?> signOut(BuildContext context, {bool forced = false}) async {
    if (!forced) {
      return showDialog(
        context: context,
        builder: (ctx) {
          return GeneralDialog(
            context,
            title: "تسجيل الخروج",
            content: "هل أنت متأكد من تسجيل الخروج من الحساب؟",
            onConfirm: () => signOut(context, forced: true),
          );
        },
      );
    }

    var result = await ApiProvider().auth.signOut();
    if (result) {
      status = AuthStatus.LOGGED_OUT;
      return true;
    } else {
      return false;
    }
  }
}
