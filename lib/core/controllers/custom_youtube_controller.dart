// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../../ui/screens/youtube_video_screen.dart';
// import '../helpers/utils/change_notifier_helpers.dart';
// import '../helpers/utils/logger.dart';

// class CustomYoutubeController extends YoutubePlayerController
//     with ChangeNotifierHelpers {
//   final String url;

//   CustomYoutubeController({
//     required super.initialVideoId,
//     required this.url,
//   });

  

//   bool _isFullScreen = false;
//   bool get isFullScreen => _isFullScreen;
//   set isFullScreen(bool v) {
//     _isFullScreen = v;
//     notifyListeners();
//   }

//   @override
//   YoutubePlayerFlags get flags => const YoutubePlayerFlags(
//         autoPlay: false,
//         controlsVisibleAtStart: false,
//         disableDragSeek: false,
//         enableCaption: false,
//         useHybridComposition: true,
//         forceHD: true,
//         hideControls: false,
//         hideThumbnail: true,
//         isLive: false,
//         loop: false,
//         mute: false,
//       );

//   Future<void> enterFullScreenMode(BuildContext context) async {
//     pause();

//     var newValue = await Navigator.push<YoutubePlayerValue>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => YoutubeVideoScreen(
//           value: value,
//           url: url,
//         ),
//       ),
//     );

//     if (newValue != null) {
//       sync(newValue);
//     }
//   }

//   void exitFullScreenMode(BuildContext context) {
//     pause();
//     Navigator.pop(context, value);
//   }

//   Future<void> sync(YoutubePlayerValue newValue) async {
//     await Future.delayed(const Duration(seconds: 3)).then((_) {
//       Logger.Magenta.log("play");
//       updateValue(newValue);
//       seekTo(newValue.position - const Duration(seconds: 3));
//     });
//   }

//   // Future<YoutubePlayerValue?> toggleFullScreen(
//   //   BuildContext context,
//   //   YoutubePlayerValue value,
//   // ) async {
//   //   pause();
//   //   if (isFullScreen) {
//   //     Navigator.pop(context, value);
//   //     return value;
//   //   } else {
//   //     if (newValue != null) {
//   //       updateValue(value);
//   //     }
//   //     return newValue;
//   //   }
//   // }
// }
