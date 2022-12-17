import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../core/controllers/file_controller.dart';
import '../../core/helpers/extensions.dart';
import '../../core/models/takwine_file.dart';
import '../theme/palette.dart';

class FileItem extends StatelessWidget {
  final TakwineFile file;
  final EdgeInsets? padding;

  const FileItem(this.file, {this.padding, super.key});

  String get fileName => "${file.name} - ${file.date}";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileController(
              context,
              file: file,
              saveName: fileName,
            ),
        builder: (context, _) {
          var controller = context.watch<FileController>();

          bool urlIsNull = file.file == null;
          bool downloading = controller.status == DownloadStatus.downloading;
          bool done = controller.status == DownloadStatus.done;
          bool error = controller.status == DownloadStatus.error;

          return Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
            child: Row(
              children: [
                Container(
                  height: 45.0,
                  width: 45.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5351FB).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                      child: Image.asset(
                    "assets/images/file.png",
                    fit: BoxFit.fitWidth,
                  )),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF3E4050),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Builder(
                        builder: (context) {
                          List<String?> strings = [
                            file.extension?.toUpperCase(),
                            file.size?.readableFileSize(),
                          ];

                          return SizedBox(
                            height: 16,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFFC2C6E2),
                                fontWeight: FontWeight.bold,
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: strings.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    strings[index] ?? "--",
                                    textDirection: TextDirection.ltr,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Text("   |   ");
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Builder(
                  builder: (context) {
                    if (downloading) {
                      return CircularPercentIndicator(
                        radius: 18.0,
                        lineWidth: 4.0,
                        progressColor: const Color(0xFF5351FB),
                        percent: controller.progress < 0
                            ? 0.0
                            : controller.progress.toDouble() * 0.01,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.transparent,
                        center: Text(
                          "${controller.progress}%",
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      );
                    } else if (done) {
                      return TextButton(
                        onPressed: controller.openFile,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5351FB),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        child: const Text("فتح"),
                      );
                    } else if (error) {
                      return Icon(
                        Icons.error,
                        color: Palette.RED.withOpacity(0.5),
                      );
                    } else {
                      if (!urlIsNull) {
                        return ElevatedButton(
                          onPressed: controller.downloadFile,
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5351FB),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size.fromRadius(18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/download.png",
                              height: 12.0,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
