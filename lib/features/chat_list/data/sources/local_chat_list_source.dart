import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:whatsapp/features/chat_list/data/models/chat_summary.dart';

class LocalChatListSource {
  Future<List<ChatSummaryModel>> read() async {
    final str = await rootBundle.loadString('assets/mock/chats.json');
    final list = (json.decode(str) as List).cast<Map<String, dynamic>>();
    return list.map(ChatSummaryModel.fromJson).toList();
  }
}