import 'package:ai4005_fe/view_model/audio_recorder_controller.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import "../object/message.dart";

class ChatScreen extends StatefulWidget {
  final AudioRecorderController audioRecorderController;
  const ChatScreen({
    required this.audioRecorderController,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://4.230.8.32:8000/talk/test/'),
  );
  bool _isRecording = false;
  bool _ableRecording = true;
  static bool _talkingAI = false;

  final player = AudioPlayer();
  final playlist = [];

  void playNextAudio() async {
    print(playlist);
    if (playlist.isNotEmpty) {
      print("HERE!");
      // If there are any URLs in the queue...
      await player.setUrl(playlist.removeAt(0));
      await player.play(); // Start playing.
      await player.pause();
    }
  }

  void listen() async {
    channel.stream.listen((message) async {
      Response response = Response.toResponse(message);
      if (response.isInputText()) {
        print('DO SOMETHING FOR INPUT TEXT');
        print(response.content);
      } else if (response.isAudioUrl()) {
        print('TALKING AI To TRUE');
        playlist.add(response.content);
        print(player.playing);
        if (!player.playing) {
          playNextAudio();
        }
      } else if (response.isOutputText()) {
        print('DO SOMETHING FOR OUTPUT TEXT');
        print(response.content);
      } else if (response.isFinish()) {
        print('TALKING AI To FALSE');
        setState(() {
          _talkingAI = false;
          _ableRecording = true;
        });
      } else {
        print('FUCKIND ELSE!');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listen();
    player.playerStateStream.listen((state) {
      if (state.playing) {}
      switch (state.processingState) {
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
          playNextAudio();
          break;
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _onRecordButtonPressed() async {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      await widget.audioRecorderController.startRecording();
    } else {
      setState(() {
        _ableRecording = false;
      });
      String? filePath = await widget.audioRecorderController.stopRecording();
      if (filePath != null) {
        widget.audioRecorderController.sendAudioData(channel, filePath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _talkingAI
                ? Image.asset('assets/catTalk.gif')
                : Image.asset('assets/closemouth.jpeg'),
            IconButton(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: _ableRecording ? _onRecordButtonPressed : null,
              padding: const EdgeInsets.only(top: 100, bottom: 10),
            ),
            Text(_isRecording ? 'Recording...' : 'Tap to record'),
          ],
        ),
      ),
    );
  }
}
