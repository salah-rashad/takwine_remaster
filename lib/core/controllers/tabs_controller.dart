import 'package:flutter/material.dart';

import '../helpers/utils/change_notifier_helpers.dart';

abstract class TabsController extends ChangeNotifier with ChangeNotifierHelpers {
  int _index = 0;
  PageController pageController = PageController();

  int get currentIndex => _index;
  set currentIndex(int value) {
    _index = value;
    notifyListeners();
  }

  void changePage(int index) {
    // index is auto assigned to "_index" property
    // through PageView's onPageChanged

    // pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeIn,
    // );

    pageController.jumpToPage(index);
  }
}
