import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';
import 'package:whatsapp/features/chat_list/domain/usecases/get_chat_list.dart';

sealed class ChatListState {}
class ChatListLoading extends ChatListState {}
class ChatListLoaded extends ChatListState { ChatListLoaded(this.items); final List<ChatSummary> items; }
class ChatListError extends ChatListState { ChatListError(this.message); final String message; }

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._get): super(ChatListLoading()); 
  final GetChatList _get;
  Future<void> load() async {
    emit(ChatListLoading());
    try { emit(ChatListLoaded(await _get())); } catch (e) { emit(ChatListError(e.toString())); }
  }
}