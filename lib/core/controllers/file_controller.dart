import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ui/theme/palette.dart';
import '../helpers/utils/app_snackbar.dart';
import '../helpers/utils/change_notifier_helpers.dart';
import '../helpers/utils/permissions_manager.dart';
import '../models/takwine_file.dart';
import '../helpers/extensions.dart';

enum DownloadStatus {
  none,
  downloading,
  done,
  error,
}

class FileController extends ChangeNotifier with ChangeNotifierHelpers {
  final BuildContext context;
  final TakwineFile file;
  final String saveName;

  FileController(
    this.context, {
    required this.file,
    required this.saveName,
  }) {
    _checkIfFileExists();
  }

  int _progress = 0;
  int get progress => _progress;
  set progress(int value) {
    _progress = value;
    notifyListeners();
  }

  DownloadStatus _status = DownloadStatus.none;
  DownloadStatus get status => _status;
  set status(DownloadStatus value) {
    _status = value;
    notifyListeners();
  }

  bool? _isFavorite;
  bool? get isFavorite => _isFavorite;
  set isFavorite(bool? value) {
    _isFavorite = value;
    notifyListeners();
  }

  String? get fileType =>
      file.extension ?? file.file?.split(".").last.toString();

  Future<void> downloadFile() async {
    if (file.file == null) return;

    String savePath = await _getFilePath();

    if (await _checkIfFileExists()) return;

    Dio dio = Dio();

    bool hasPermission =
        await PermissionsManager.checkPermission(Permission.storage);

    if (hasPermission) {
      bool downloadAccepted = await _showConfirmDownloadBottomSheet();

      if (downloadAccepted) {
        status = DownloadStatus.downloading;
        try {
          await dio.download(
            file.file!,
            savePath,
            onReceiveProgress: (rcv, total) {
              if (kDebugMode) {
                print(
                    'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
              }

              progress = ((rcv / total) * 100).floor();
            },
            deleteOnError: true,
          );
        } catch (e) {
          status = DownloadStatus.error;
          AppSnackbar.error(
            message:
                "حدث خطأ ما أثناء تحميل ملف $fileType ، يرجى المحاولة في وقت لاحق.",
          );
        }

        if (progress == 100) {
          status = DownloadStatus.done;
        }
      }
    }
  }

  void openFile() async {
    String path = await _getFilePath();
    OpenFile.open(path);
  }

  Future<String> _getFilePath() async {
    String path = '';

    try {
      Directory dir;

      if (Platform.isAndroid) {
        var documentsPath =
            await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOCUMENTS,
        );

        // path:   /storage/emulated/0/Documents/Takwine/
        dir = await Directory('$documentsPath/Takwine').create(recursive: true);
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      path = '${dir.path}/$saveName.$fileType';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }

    return path;
  }

  Future<bool> _checkIfFileExists() async {
    String path = await _getFilePath();
    File file = File(path);
    bool isExists = await file.exists();
    if (isExists) {
      status = DownloadStatus.done;
    }
    return isExists;
  }

  Future<bool> _showConfirmDownloadBottomSheet() async {
    return await showModalBottomSheet<bool>(
          context: context,
          backgroundColor: Palette.WHITE,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              topLeft: Radius.circular(16.0),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "طلب تحميل ملف",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "النوع:   ",
                      children: [
                        TextSpan(
                            text: fileType!.toUpperCase(),
                            style: const TextStyle(color: Colors.blueGrey))
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "الحجم:   ",
                      children: [
                        TextSpan(
                          text: file.size?.readableFileSize(),
                          style: const TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.BLUE2,
                        ),
                        child: const Text(
                          "تحميل",
                          style: TextStyle(color: Palette.WHITE),
                        ),
                        onPressed: () {
                          Navigator.pop<bool>(context, true);
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Palette.RED,
                        ),
                        child: const Text("إلغاء"),
                        onPressed: () {
                          Navigator.pop<bool>(context, false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
