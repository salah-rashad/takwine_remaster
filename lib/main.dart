import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:provider/provider.dart';

import 'core/helpers/constants/constants.dart';
import 'core/helpers/controllers.dart';
import 'core/helpers/routes/route_generator.dart';
import 'core/helpers/routes/routes.dart';
import 'core/helpers/utils/cache_manager.dart';
import 'core/helpers/utils/go.dart';
import 'ui/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await CacheManager.authStorage.initStorage;
  await CacheManager.generalStorage.initStorage;

  await intl.initializeDateFormatting("ar_MA");

  await CacheManager.authStorage.erase();
  await CacheManager.generalStorage.erase();

  runApp(
    MultiProvider(
      providers: controllers,
      child: MaterialApp(
        title: Platform.localeName.contains("ar") ? APP_NAME_AR : APP_NAME_EN,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial,
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        ),
        onGenerateRoute: RouteGenerator.onGenerate,
        theme: AppTheme.lightTheme,
        navigatorKey: Go().navigatorKey,
        locale: const Locale("ar", "MA"),
      ),
    ),
  );
}
