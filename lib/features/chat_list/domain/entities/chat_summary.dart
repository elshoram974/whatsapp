import 'package:equatable/equatable.dart';

class ChatSummary extends Equatable {
  const ChatSummary({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastTime,
    required this.unread,
  });
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime lastTime;
  final int unread;

  @override
  List<Object?> get props => [id, name, avatar, lastMessage, lastTime, unread];
}