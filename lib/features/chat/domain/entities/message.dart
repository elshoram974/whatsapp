import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({required this.id, required this.chatId, required this.fromMe, required this.text, required this.time});
  final String id; final String chatId; final bool fromMe; final String text; final DateTime time;
  @override List<Object?> get props => [id, chatId, fromMe, text, time];
}