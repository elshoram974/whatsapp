import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/message.dart';

class LocalChatSource {
  Future<List<MessageModel>> read(String chatId) async {
    final id = chatId.trim().replaceAll('"', '');
    final path = 'assets/mock/messages_chat_$id.json';
    try {
      final str = await rootBundle.loadString(path);
      if (str.trim().isEmpty) {
        throw Exception('Empty JSON: $path');
      }
      final list = (json.decode(str) as List).cast<Map<String, dynamic>>();
      return list.map(MessageModel.fromJson).toList();
    } on FlutterError {
      throw Exception('Missing asset: $path');
    } on FormatException {
      throw Exception('Invalid JSON: $path');
    }
  }
}
