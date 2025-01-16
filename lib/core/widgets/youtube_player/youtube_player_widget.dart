import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoId;
  const YoutubePlayerWidget({
    super.key,
    required this.videoId,
  });

  @override
  State<StatefulWidget> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerWidget>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    initVideoPlayer();
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller.dispose();

    super.dispose();
  }

  Future<void> initVideoPlayer() async {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideThumbnail: false,
        controlsVisibleAtStart: false,
        useHybridComposition: false,
        disableDragSeek: false,
        showLiveFullscreenButton: false,
        isLive: false,
        loop: false,
        mute: false,
        hideControls: false,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(player: YoutubePlayer(
      controller: _controller,
      aspectRatio: 1.51,
      onReady: () {

      },
    ), builder:(context, player) =>  player,)
     ;
  }
}
