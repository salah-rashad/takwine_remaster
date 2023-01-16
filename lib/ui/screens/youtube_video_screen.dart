import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoScreen extends StatefulWidget {
  final String videoId;
  const YoutubeVideoScreen({
    super.key,
    required this.videoId,
  });

  @override
  State<YoutubeVideoScreen> createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late final YoutubePlayerController controller;

  String get videoId => widget.videoId;

  @override
  void initState() {
    /* var getIt = GetIt.instance;

    controller = getIt.get<YoutubePlayerController>(instanceName: videoId); */

    // controller.addListener(() {
    //   if (!controller.value.isControlsVisible) {
    //     hideOverlays();
    //   }
    // });

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]).then((_) => hideOverlays());

    super.initState();
  }

  @override
  void dispose() {
    // controller.pause();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]).then((_) => showOverlays());

    super.dispose();
  }

  void showOverlays() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void hideOverlays() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (p0, p1) {
          return p1;
        },
      ),
    );
  }
}
