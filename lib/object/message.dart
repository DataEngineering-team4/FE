import 'dart:convert';

class Message {
  final String audioFile;

  Message({required this.audioFile});
}

class Response {
  final String type;
  final String content;

  Response({required this.type, required this.content});

  static Response toResponse(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return Response(type: data['type']!, content: data['content']!);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content,
    };
  }

  bool isAudioUrl() {
    return type == 'audio_url';
  }

  bool isInputText() {
    return type == 'input_text';
  }

  bool isOutputText() {
    return type == 'output_text';
  }

  bool isFinish() {
    return type == "finish_signal";
  }
}
