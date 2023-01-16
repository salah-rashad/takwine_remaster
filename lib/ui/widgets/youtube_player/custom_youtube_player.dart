// import 'package:flutter/material.dart';
// import 'package:get_it_mixin/get_it_mixin.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../../../core/controllers/custom_youtube_controller.dart';
// import '../../../core/helpers/utils/helpers.dart';
// import '../../theme/palette.dart';

// class CustomYoutubePlayer extends StatelessWidget with GetItMixin {
//   final CustomYoutubeController controller;
//   final VoidCallback? onReady;
//   CustomYoutubePlayer({
//     super.key,
//     required this.controller,
//     this.onReady,
//   });

//   static final _progressBarColors = ProgressBarColors(
//     backgroundColor: Palette.BLACK,
//     bufferedColor: Palette.WHITE.withOpacity(0.5),
//     playedColor: Palette.BLUE1,
//     handleColor: Palette.BLUE1,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayer(
//       controller: controller,
//       liveUIColor: Palette.RED,
//       showVideoProgressIndicator: true,
//       progressColors: CustomYoutubePlayer._progressBarColors,
//       onReady: onReady,
//       bottomActions: [
//         IconButton(
//           icon: Icon(
//             controller.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
//             textDirection: TextDirection.ltr,
//           ),
//           onPressed: () async {
//             if (controller.isFullScreen) {
//               Navigator.pop(context, controller.value);
//             } else {
//               controller.enterFullScreenMode(context);
//             }
//           },
//           color: Palette.WHITE,
//           tooltip: controller.isFullScreen ? "تصغير الشاشة" : "تكبير الشاشة",
//         ),
//         const SizedBox(width: 8.0),
//         CurrentPosition(),
//         const SizedBox(width: 8.0),
//         ProgressBar(
//           isExpanded: true,
//           colors: CustomYoutubePlayer._progressBarColors,
//         ),
//         const SizedBox(width: 16.0),
//         const PlaybackSpeedButton(
//           icon: Icon(
//             Icons.speed_rounded,
//             color: Palette.WHITE,
//           ),
//         ),
//       ],
//       topActions: [
//         IconButton(
//           icon: const Icon(
//             Icons.open_in_new_rounded,
//             textDirection: TextDirection.ltr,
//           ),
//           onPressed: () {
//             controller.pause();
//             launchURL(controller.url);
//           },
//           color: Palette.GRAY,
//           tooltip: "مشاهدة على يوتيوب",
//         ),
//       ],
//       onEnded: (metaData) {
//         controller.seekTo(const Duration(seconds: 0));
//         controller.pause();
//       },
//     );
//   }
// }