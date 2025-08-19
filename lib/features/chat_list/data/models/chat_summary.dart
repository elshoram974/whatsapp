import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart' as d;

class ChatSummaryModel {
  ChatSummaryModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastTime,
    required this.unread,
  });

  factory ChatSummaryModel.fromJson(Map<String, dynamic> json) => ChatSummaryModel(
        id: json['id'] as String,
        name: json['name'] as String,
        avatar: json['avatar'] as String,
        lastMessage: json['lastMessage'] as String,
        lastTime: DateTime.parse(json['lastTime'] as String),
        unread: (json['unread'] as num).toInt(),
      );
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime lastTime;
  final int unread;

  d.ChatSummary toDomain() => d.ChatSummary(
        id: id, name: name, avatar: avatar, lastMessage: lastMessage, lastTime: lastTime, unread: unread,
      );
}