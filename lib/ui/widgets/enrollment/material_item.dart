import 'package:flutter/material.dart';

import '../../../core/models/course_models/material/lesson_material.dart';

class MaterialItem extends StatelessWidget {
  final LessonMaterial material;

  const MaterialItem(this.material, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          material.title!,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        /* Builder(
          builder: (context) {
            List<Widget> contentList = [];

            contentList.clear();
            material.components!.forEach((component) {
              switch (component.type) {
                case "text":
                  contentList.add(Text(
                    component.data!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF515C6F),
                    ),
                  ));
                  break;
                case "picture":
                  {
                    contentList.add(
                      CachedNetworkImage(
                        imageUrl: ApiURLs.HOST_URL +
                            "/assets/uploads/materiel/" +
                            component.data!,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) {
                          return Container(
                            color: Clr.GRAY.withOpacity(0.7),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            color: Clr.GRAY.withOpacity(0.7),
                          );
                        },
                      ),
                    );
                  }

                  break;
                case "video":
                  {
                    var _controller = YoutubePlayerController(
                      initialVideoId: component.data!,
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        captionLanguage: "ar",
                      ),
                    );

                    var progressBarColors = ProgressBarColors(
                      backgroundColor: Clr.BLACK,
                      bufferedColor: Clr.WHITE.withOpacity(0.5),
                      playedColor: Clr.BLUE1,
                      handleColor: Clr.BLUE1,
                    );

                    contentList.add(YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Clr.RED,
                      progressColors: progressBarColors,
                      bottomActions: [
                        const SizedBox(width: 14.0),
                        CurrentPosition(),
                        const SizedBox(width: 8.0),
                        ProgressBar(
                          isExpanded: true,
                          colors: progressBarColors,
                        ),
                        RemainingDuration(),
                        const SizedBox(width: 8.0),
                        const PlaybackSpeedButton(
                          icon: Icon(
                            Icons.speed_rounded,
                            color: Clr.GRAY,
                          ),
                        ),
                      ],
                      topActions: [
                        IconButton(
                          icon: Icon(Icons.open_in_new_rounded),
                          onPressed: () {
                            _controller.pause();
                            launchYoutubeURL(component.data!);
                          },
                          color: Clr.GRAY,
                          tooltip: "مشاهدة على يوتيوب",
                        ),
                      ],
                      onEnded: (metaData) {
                        _controller.seekTo(Duration(seconds: 0));
                        _controller.pause();
                      },
                    ));
                  }
                  break;
              }
            });

            return Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: contentList.length,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return contentList[index];
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.0);
                  },
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: material.attachments!.length,
                  padding: EdgeInsets.only(top: 16.0),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    MaterialAttachment file = material.attachments![index];
                    return CourseFileItem(
                      file: file,
                      materialTitle: material.title,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Clr.GRAY,
                    );
                  },
                ),
              ],
            );
          },
        ) */
      ],
    );
  }
}
