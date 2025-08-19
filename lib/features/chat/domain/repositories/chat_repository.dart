import 'package:whatsapp/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String chatId);
  Future<Message> send(String chatId, String text);
}