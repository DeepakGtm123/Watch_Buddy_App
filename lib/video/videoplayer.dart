import 'package:flutter/material.dart';
import 'package:video/video_player.dart';

void main() {
  runApp(VideoPlayerApp());
}

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  TextEditingController _urlController = TextEditingController();
  bool _isVideoFromDevice = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/sample_video.mp4') 
    //Make sure to replace 'assets/sample_video.mp4' with the path to your 
    //video file in your Flutter project.
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playVideoFromDevice() async {
    final videoFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (videoFile == null) return;
    final videoController = VideoPlayerController.file(videoFile);
    await videoController.initialize();
    setState(() {
      _controller = videoController;
      _isVideoFromDevice = true;
    });
    _controller.play();
  }

  void _playVideoFromUrl() {
    final url = _urlController.text;
    if (url.isEmpty) return;
    final videoController = VideoPlayerController.network(url);
    videoController.initialize().then((_) {
      setState(() {
        _controller = videoController;
        _isVideoFromDevice = false;
      });
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Code for screen sharing
            },
          ),
        ],
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Choose Video Source'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: true,
                          groupValue: _isVideoFromDevice,
                          onChanged: (value) {
                            setState(() {
                              _isVideoFromDevice = value;
                            });
                          },
                        ),
                        Text('From Device'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: false,
                          groupValue: _isVideoFromDevice,
                          onChanged: (value) {
                            setState(() {
                              _isVideoFromDevice = value;
                            });
                          },
                        ),
                        Text('From URL'),
                      ],
                    ),
                    if (!_isVideoFromDevice)
                      TextField(
                        controller: _urlController,
                      ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Play'),
                    onPressed: (){
                      Navigator.of(context).pop();
                      if (_isVideoFromDevice) {
                        _playVideoFromDevice();
                      } else {
                        _playVideoFromUrl();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
