import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repository.dart';

class GetMessages { 
  GetMessages(this._repo); 
  final ChatRepository _repo; 
  Future<List<Message>> call(String chatId)=>_repo.getMessages(chatId); 
}