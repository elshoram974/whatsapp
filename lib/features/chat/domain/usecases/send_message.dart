import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repository.dart';

class SendMessage { 
  SendMessage(this._repo); 
  final ChatRepository _repo; 
  Future<Message> call(String chatId, String text)=>_repo.send(chatId, text); 
}