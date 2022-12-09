// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class CourseVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  const CourseVideoScreen({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
  late VideoPlayerController _controller;

  bool showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  static const List<double> examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _controller.value.isInitialized
                  ? InkWell(
                      onTap: () {
                        setState(
                          () {
                            showControls = !showControls;
                          },
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_controller),
                            showControls
                                ? Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                          _controller.value.isPlaying
                                              ? showControls = false
                                              : showControls = true;
                                        });
                                      },
                                      child: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 50,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  )
                                : Container(),
                            showControls
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            showControls
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ValueListenableBuilder(
                                              valueListenable: _controller,
                                              builder: (context,
                                                  VideoPlayerValue value,
                                                  child) {
                                                return Text(
                                                  _videoDuration(
                                                      value.position),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: VideoProgressIndicator(
                                              _controller,
                                              allowScrubbing: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              _videoDuration(
                                                  _controller.value.duration),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // PopupMenuButton<double>(
                                          //   initialValue:
                                          //       _controller.value.playbackSpeed,
                                          //   tooltip: 'Playback speed',
                                          //   onSelected: (double speed) {
                                          //     _controller.setPlaybackSpeed(speed);
                                          //   },
                                          //   itemBuilder: (BuildContext context) {
                                          //     return <PopupMenuItem<double>>[
                                          //       for (final double speed
                                          //           in examplePlaybackRates)
                                          //         PopupMenuItem<double>(
                                          //           value: speed,
                                          //           child: Text('${speed}x'),
                                          //         )
                                          //     ];
                                          //   },
                                          //   child: Text(
                                          //     '${_controller.value.playbackSpeed}x',
                                          //     style: const TextStyle(
                                          //       color: Colors.white,
                                          //       fontWeight: FontWeight.bold,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 500,
                      width: 800,
                      child: Center(
                        child: Lottie.asset('assets/json/buffering.json'),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                child: Text(
                  widget.videoTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
