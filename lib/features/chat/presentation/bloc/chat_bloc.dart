import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';
import 'package:whatsapp/features/chat/domain/usecases/get_messages.dart';
import 'package:whatsapp/features/chat/domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._get, this._send) : super(const ChatState()) {
    on<ChatOpened>(_onOpen);
    on<ChatSend>(_onSend);
  }
  final GetMessages _get; final SendMessage _send;

  Future<void> _onOpen(ChatOpened e, Emitter<ChatState> emit) async {
    emit(state.copyWith(loading: true));
    final items = await _get(e.chatId);
    emit(state.copyWith(loading: false, items: items));
  }

  Future<void> _onSend(ChatSend e, Emitter<ChatState> emit) async {
    final msg = await _send(e.chatId, e.text);
    final items = List<Message>.from(state.items)..add(msg);
    emit(state.copyWith(items: items, insertedKey: msg.id));
    emit(state.copyWith());
  }
}