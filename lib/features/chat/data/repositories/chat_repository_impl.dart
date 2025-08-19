import 'package:whatsapp/features/chat/data/sources/local_chat_source.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._source);
  final LocalChatSource _source;
  final _memory = <String, List<Message>>{}; // append-only for demo

  @override
  Future<List<Message>> getMessages(String chatId) async {
    final base = (await _source.read(chatId)).map((e) => e.toDomain()).toList();
    final mem = _memory[chatId] ?? const <Message>[];
    return [...base, ...mem]..sort((a,b)=>a.time.compareTo(b.time));
  }

  @override
  Future<Message> send(String chatId, String text) async {
    final msg = Message(id: DateTime.now().microsecondsSinceEpoch.toString(), chatId: chatId, fromMe: true, text: text, time: DateTime.now());
    _memory.putIfAbsent(chatId, () => <Message>[]).add(msg);
    return msg;
  }
}