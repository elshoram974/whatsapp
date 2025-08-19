part of 'chat_bloc.dart';

sealed class ChatEvent { const ChatEvent(); }
class ChatOpened extends ChatEvent { const ChatOpened(this.chatId); final String chatId; }
class ChatSend extends ChatEvent { const ChatSend(this.chatId, this.text); final String chatId; final String text; }