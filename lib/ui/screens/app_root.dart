import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../core/controllers/auth/auth_controller.dart';
import '../../core/helpers/extensions.dart';

import '../../core/helpers/routes/routes.dart';
import '../widgets/home_banner.dart';
import '../widgets/smart_layout.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "اضغط على زر الرجوع مرة أخرى للمغادرة",
        toastLength: Toast.LENGTH_SHORT,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuery.size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFEADCFF),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 100.0,
                    horizontal: 32.0,
                  ),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/floating_illustrations.png",
                    cacheWidth: size.width.toInt(),
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Image.asset(
                  "assets/images/bottom_clouds.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  cacheWidth: size.width.toInt(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height / 4.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            "assets/images/thumps_up_right.png",
                            cacheWidth: size.width ~/ 2,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: size.width / 2.5),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            "assets/images/thumps_up_left.png",
                            cacheWidth: size.width ~/ 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height / 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          "assets/images/guy.png",
                          cacheWidth: size.width.toInt(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              SmartLayout(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "تعلَّم على منصة تكوين",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF643A89),
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "أول منصة شبابية تثقيفية توعوية في المغرب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF643A89),
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 32.0),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeBanner(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.COURSES),
                          imagePath: "assets/images/courses_bg.png",
                          title: "الدورات التكوينية",
                          subtitle: "كل الدورات مجانية",
                        ),
                        HomeBanner(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.DOCUMENTS),
                          imagePath: "assets/images/docs_bg.png",
                          title: "بنك المعلومات",
                          subtitle: "كل المواد مجانية",
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<AuthController>().signOut(context),
                          child: const Text("Sign Out"),
                        )
                      ],
                    ),
                    Expanded(child: Container())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
