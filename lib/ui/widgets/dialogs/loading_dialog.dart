import 'package:flutter/material.dart';

import '../../theme/palette.dart';

Future<void> showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              color: Palette.WHITE,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("انتظر من فضلك"),
                    SizedBox(
                      height: 16.0,
                    ),
                    LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
