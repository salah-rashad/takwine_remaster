import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/login_controller.dart';

List<SingleChildWidget> controllers = [
  ChangeNotifierProvider(
    create: (context) => AuthController(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => LoginController(),
    lazy: true,
  ),
];
