import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';

abstract class ChatListRepository {
  Future<List<ChatSummary>> getChats();
}