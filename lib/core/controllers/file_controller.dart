import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ui/theme/palette.dart';
import '../helpers/utils/permissions_manager.dart';

enum DownloadStatus {
  none,
  downloading,
  done,
}

class FileController extends ChangeNotifier {
  final BuildContext context;
  final String? fileUrl;
  final String saveName;

  FileController(
    this.context, {
    required this.fileUrl,
    required this.saveName,
  }) {
    checkIfFileExists();
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

  String? get fileType => fileUrl?.split(".").last.toString();

  Future<void> downloadFile() async {
    if (fileUrl == null) return;

    String savePath = await getFilePath();

    if (await checkIfFileExists()) return;

    Dio dio = Dio();

    bool hasPermission =
        await PermissionsManager.checkPermission(Permission.storage);

    if (hasPermission) {
      bool downloadAccepted = await confirmDownloadBottomSheet(fileType);

      if (downloadAccepted) {
        status = DownloadStatus.downloading;
        await dio.download(
          fileUrl!,
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

        if (progress == 100) {
          status = DownloadStatus.done;
        }
      }
    }
  }

  Future<String> getFilePath() async {
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

  Future<bool> checkIfFileExists() async {
    String path = await getFilePath();
    File file = File(path);
    bool isExists = await file.exists();
    if (isExists) {
      status = DownloadStatus.done;
    }
    return isExists;
  }

  void openFile() async {
    String path = await getFilePath();
    OpenFile.open(path);
  }

  Future<bool> confirmDownloadBottomSheet(String? fileType) async {
    return await showModalBottomSheet<bool>(
          context: context,
          builder: (context) => Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Palette.WHITE,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("سيتم تحميل ملف ${fileType!.toUpperCase()}"),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.BABY_BLUE,
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.WHITE,
                      ),
                      child: const Text(
                        "إلغاء",
                        style: TextStyle(color: Palette.RED),
                      ),
                      onPressed: () {
                        Navigator.pop<bool>(context, false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) ??
        false;
  }
}
