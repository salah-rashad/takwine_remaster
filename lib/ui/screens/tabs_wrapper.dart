// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/controllers/auth/auth_controller.dart';
import '../../core/controllers/tabs_controller.dart';
import '../../core/helpers/extensions.dart';
import '../../core/models/app_tab.dart';
import '../widgets/navbars/bottom_navbar.dart';

class TabsWrapper<T extends TabsController> extends StatelessWidget {
  final Create<T> controller;
  final List<AppTab> Function(T controller) tabs;
  final int homeIndex;

  const TabsWrapper({
    super.key,
    required this.controller,
    required this.tabs,
    this.homeIndex = 0,
  });

  EdgeInsets safePadding(BuildContext context) {
    return EdgeInsets.only(
      bottom:
          120.0 + (Platform.isIOS ? context.mediaQuery.padding.bottom : 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return ChangeNotifierProvider<T>(
      create: controller,
      builder: (context, child) {
        var controller = context.watch<T>();

        return WillPopScope(
          onWillPop: () {
            if (controller.currentIndex == 0) {
              return Future.value(true);
            } else {
              controller.changePage(0);
              return Future.value(false);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: !auth.isLoggedIn
                ? _tabView(context, controller, homeIndex)
                : Stack(
                    children: [
                      PageView.builder(
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          FocusScope.of(context).unfocus();
                          controller.currentIndex = index;
                          _refresh(controller, index, force: false);
                        },
                        controller: controller.pageController,
                        itemCount: tabs(controller).length,
                        itemBuilder: (context, index) {
                          return _tabView(context, controller, index);
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomNavBar<T>(tabs: tabs(controller)),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _refresh(T controller, int index, {bool force = true}) async {
    try {
      return tabs(controller)[index].onRefresh(force);
    } catch (e) {
      rethrow;
    }
  }

  Widget _tabView(BuildContext context, T controller, int index) {
    var size = context.mediaQuery.size;
    var tab = tabs(controller)[index];

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: tab.colors.first),
      ),
      child: RefreshIndicator(
        onRefresh: () => _refresh(controller, index),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: safePadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: tab.page(tab.colors),
          ),
        ),
      ),
    );
  }

  // Widget homeTab(T controller) {
  //   var _tabs = tabs(controller);

  //   return RefreshIndicator(
  //     onRefresh: () => _tabs[homeIndex].onRefresh(true),
  //     child: SingleChildScrollView(
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       child: _tabs[homeIndex].page(_tabs[homeIndex].colors),
  //     ),
  //   );
  // }
}
