import 'package:flutter/material.dart';

import '../../theme/palette.dart';

class CelebrationDialog extends StatelessWidget {
  const CelebrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.antiAlias,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF854B9F), Color(0xFF45145C)],
              ),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset("assets/images/gift_box.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("تهانينا!",
                    style: TextStyle(fontSize: 32.0),
                    textAlign: TextAlign.center),
                const Text(
                  "لقد أكملتم الدورة بنجاح",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () => proccess(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.NEARLY_BLACK1,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                  ),
                  child: const Text("إغلاق"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void proccess(BuildContext context) {
    Navigator.pop(context);
    // Navigator.popUntil(context, ModalRoute.withName(Routes.COURSES));
  }
}
