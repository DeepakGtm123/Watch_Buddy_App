import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late File _videoFile;
  late String _videoUrl;
  bool _isSharingScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/sample_video.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(() {
      if (_controller.value.isPlaying && !_isSharingScreen) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> chooseVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    _videoFile = File(result!.files.single.path);
    _controller = VideoPlayerController.file(_videoFile);
    _initializeVideoPlayerFuture = _controller.initialize();
    
    setState(() {});
  }

  Future<void> searchVideo(String url) async {
    _videoUrl = url;
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(_videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    
    setState(() {});
  }

  Future<void> shareScreenWithFriends() async {
    setState(() {
      _isSharingScreen = !_isSharingScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: chooseVideo,
            child: const Text('Choose Video'),
          ),
          ElevatedButton(
            onPressed: () => searchVideo(_videoUrl),
            child: const Text('Search Video'),
          ),
          ElevatedButton(
            onPressed: shareScreenWithFriends,
            child: Text(_isSharingScreen ? 'Stop Sharing' : 'Share Screen'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
