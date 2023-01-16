import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../ui/widgets/dialogs/general_dialog.dart';
import '../../helpers/enums/auth_status_enum.dart';
import '../../helpers/utils/cache_manager.dart';
import '../../helpers/utils/change_notifier_helpers.dart';
import '../../models/course_models/enrollment/enrollment.dart';
import '../../models/user_models/user.dart';
import '../../services/api_account.dart';
import '../../services/api_auth.dart';

class AuthController extends ChangeNotifier with ChangeNotifierHelpers {
  AuthController() {
    initialize();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Enrollment? _lastActivity;
  Enrollment? get lastActivity => _lastActivity;
  set lastActivity(Enrollment? value) {
    _lastActivity = value;
    notifyListeners();
  }

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
        if (!isTokenExpired) {
          status = AuthStatus.LOGGED_IN;
          fetchLastActivity();
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error token: $fullToken");
          print(e);
        }
      }
    }

    user = await ApiAccount.getProfile();

    if (user != null) {
      status = AuthStatus.LOGGED_IN;
      fetchLastActivity();
    }

    if (!isLoggedIn) {
      CacheManager.accountStorage.erase();
      CacheManager.accountStorage.save();
    }
  }

  Future<void> updateLastActivity(int? courseId) async {
    lastActivity = await ApiAccount.updateLastActivity(courseId);
  }

  Future<void> fetchLastActivity() async {
    lastActivity = await ApiAccount.getLastActivity();
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

    var result = await ApiAuth.signOut();
    if (result) {
      status = AuthStatus.LOGGED_OUT;
      user = null;
      lastActivity = null;

      CacheManager.authStorage.erase();
      CacheManager.authStorage.save();

      CacheManager.accountStorage.erase();
      CacheManager.accountStorage.save();

      return true;
    } else {
      return false;
    }
  }
}
