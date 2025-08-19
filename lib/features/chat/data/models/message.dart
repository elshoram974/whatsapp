import 'package:whatsapp/features/chat/domain/entities/message.dart' as d;

class MessageModel {
  MessageModel({required this.id, required this.chatId, required this.fromMe, required this.text, required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] as String,
    chatId: json['chatId'] as String,
    fromMe: json['fromMe'] as bool,
    text: json['text'] as String,
    time: DateTime.parse(json['time'] as String),
  );
  final String id; final String chatId; final bool fromMe; final String text; final DateTime time;

  d.Message toDomain() => d.Message(id: id, chatId: chatId, fromMe: fromMe, text: text, time: time);
}