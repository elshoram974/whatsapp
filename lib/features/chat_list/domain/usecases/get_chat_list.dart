import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';
import 'package:whatsapp/features/chat_list/domain/repositories/chat_list_repository.dart';

class GetChatList {
  GetChatList(this._repo);
  final ChatListRepository _repo;
  Future<List<ChatSummary>> call() => _repo.getChats();
}