import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth/auth_controller.dart';
import 'auth/login_controller.dart';
import 'auth/register_controller.dart';

List<SingleChildWidget> controllers = [
  ChangeNotifierProvider(
    create: (context) => AuthController(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => LoginController(),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (context) => RegisterController(),
    lazy: true,
  ),
];
