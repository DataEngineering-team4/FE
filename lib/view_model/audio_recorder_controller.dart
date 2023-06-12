import 'dart:convert';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../object/message.dart';

class AudioRecorderController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  String? _recordingFilePath = '/sdcard/Download/temp.wav';
  List<Message>? messageList = [];

  Future<void> startRecording() async {
    await _recorder.openRecorder();
    await _recorder.startRecorder(toFile: _recordingFilePath);
  }

  Future<String?> stopRecording() async {
    // tempFilePath = /Users/eomtaejun/Library/Developer/CoreSimulator/Devices/8F76A02B-7407-4901-9286-0F7558F271A6/data/Containers/Data/Application/043B08A0-CE37-4FE5-BBCF-BFEBF76056A8/tmp/temp.wav
    // String? tempFilePath = await _recorder.stopRecorder();
    await _recorder.stopRecorder();
    _recordingFilePath = _recordingFilePath;
    await _recorder.closeRecorder();
    return _recordingFilePath;
  }

  void sendAudioData(WebSocketChannel channel, String filePath) async {
    final audioFileBytes = await File(filePath).readAsBytes();
    final base64AudioFile = base64Encode(audioFileBytes);
    channel.sink.add(jsonEncode({'audio_file': base64AudioFile}));
  }

  void dispose() {
    if (_recorder.isRecording || _recorder.isPaused) {
      _recorder.closeRecorder();
    }
  }
}
