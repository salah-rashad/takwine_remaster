enum PlaybackQuality {
  small("240p"),
  medium("360p"),
  large("480p"),
  hd720("720p"),
  hd1080("1080p"),
  highres("HD+");

  final String friendlyName;
  const PlaybackQuality(this.friendlyName);
}
