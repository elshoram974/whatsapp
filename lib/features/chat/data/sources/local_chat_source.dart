import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:whatsapp/features/chat/data/models/message.dart';

class LocalChatSource {
  Future<List<MessageModel>> read(String chatId) async {
    final str = await rootBundle.loadString('assets/mock/messages_chat_$chatId.json');
    final list = (json.decode(str) as List).cast<Map<String, dynamic>>();
    return list.map(MessageModel.fromJson).toList();
  }
}