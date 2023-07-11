import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  bool _isLocalVideo = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('videos/sample_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPlayer() {
    if (_controller != null && _controller.value.initialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  void loadVideoFromDevice() {
    _controller = VideoPlayerController.asset('videos/sample_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    setState(() {
      _isLocalVideo = true;
    });
  }

  void loadVideoFromUrl() {
    String url = _urlController.text;
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
    setState(() {
      _isLocalVideo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildPlayer(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Load from Device'),
                  onPressed: loadVideoFromDevice,
                ),
                SizedBox(width: 20.0),
                RaisedButton(
                  child: Text('Load from URL'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Load Video from URL'),
                          content: TextField(
                            controller: _urlController,
                            decoration: InputDecoration(
                              labelText: 'Enter URL',
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Load'),
                              onPressed: () {
                                loadVideoFromUrl();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              _isLocalVideo ? 'Loaded from Device' : 'Loaded from URL',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
