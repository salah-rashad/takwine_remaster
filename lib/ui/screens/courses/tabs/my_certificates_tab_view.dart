import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/controllers/auth/auth_controller.dart';
import '../../../../core/controllers/courses/courses_controller.dart';
import '../../../../core/helpers/constants/urls.dart';
import '../../../../core/models/course_models/enrollment/certificate.dart';
import '../../../theme/palette.dart';
import '../../../widgets/course/certificate_item.dart';
import '../../../widgets/user_widget.dart';
import '../../../widgets/login_required_widget.dart';
import '../../../widgets/shimmers/certificate_item_shimmer.dart';

class MyCertificatesTabView extends StatelessWidget {
  final List<Color> colors;
  const MyCertificatesTabView(this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // represents the status bar height
                height: MediaQuery.of(context).padding.top,
              ),
              const UserWidget(),
              const SizedBox(height: 22.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "شواهدي",
                      style: TextStyle(color: Palette.WHITE, fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/characters_book.png"),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Selector<CoursesController, List<Certificate>?>(
            selector: (p0, p1) => p1.certificates,
            builder: (context, certificates, _) {
              return !auth.isLoggedIn
                  ? const LoginRequiredWidget()
                  : Builder(
                      builder: (context) {
                        if (certificates != null) {
                          if (certificates.isEmpty) {
                            return const Center(
                              child: Text(
                                "لم تحصل على شواهد بعد.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Palette.LIGHT_TEXT_COLOR,
                                  fontSize: 14.0,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: certificates.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var certificate = certificates[index];
                              return CertificateItem(
                                certificate,
                                onPressed: () => onPressedCertificateItem(
                                    context, certificate),
                                onPressedDownload: () =>
                                    downloadCertificate(certificate),
                              );
                            },
                          );
                        } else {
                          return Column(
                            children:
                                List.filled(3, const CertificateItemShimmer()),
                          );
                        }
                      },
                    );
            },
          ),
        )
      ],
    );
  }

  void onPressedCertificateItem(BuildContext context, Certificate certificate) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("عرض الشهادة"),
            actions: [
              IconButton(
                onPressed: () => downloadCertificate(certificate),
                icon: const Icon(Icons.download_rounded),
              ),
            ],
          ),
          body: SfPdfViewer.network(ViewUrls.CERTIFICATE(certificate.id)),
        );
      },
    ));
  }

  Future<void> downloadCertificate(Certificate certificate) async {
    launchUrlString(
      ViewUrls.CERTIFICATE(certificate.id),
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
        headers: {"download": "true"},
      ),
    );
  }
}
