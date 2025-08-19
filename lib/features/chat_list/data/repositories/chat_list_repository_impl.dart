import 'package:whatsapp/features/chat_list/data/sources/local_chat_list_source.dart';
import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';
import 'package:whatsapp/features/chat_list/domain/repositories/chat_list_repository.dart';

class ChatListRepositoryImpl implements ChatListRepository {
  ChatListRepositoryImpl(this._source);
  final LocalChatListSource _source;
  @override
  Future<List<ChatSummary>> getChats() async => (await _source.read()).map((e) => e.toDomain()).toList();
}