import 'package:flutter/material.dart';

import '../../../core/helpers/utils/helpers.dart';
import '../../../core/models/course_models/enrollment/certificate.dart';
import '../../theme/palette.dart';

class CertificateItem extends StatelessWidget {
  final Certificate certificate;
  final VoidCallback onPressed;
  final VoidCallback onPressedDownload;

  const CertificateItem(
    this.certificate, {
    required this.onPressed,
    required this.onPressedDownload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Palette.WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 64,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Material(
                      color: Palette.BLUE1.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: onPressedDownload,
                        child: const Center(
                          child: Icon(
                            Icons.download_rounded,
                            color: Palette.BLUE1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "شهادة إتمام",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Palette.BLUE1.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        certificate.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF3E4050),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "تاريخ : ${formatDate(certificate.date ?? "")}",
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF6B6E7B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                const Icon(
                  Icons.star,
                  color: Color(0xFFFBB438),
                  size: 14,
                ),
                const SizedBox(width: 4.0),
                Text(
                  "${certificate.result}%",
                  style: const TextStyle(
                    color: Palette.DARKER_TEXT_COLOR,
                    fontSize: 14.0,
                    fontFamily: "",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
