part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({this.loading=false, this.items=const [], this.insertedKey});
  final bool loading; final List<Message> items; final String? insertedKey;
  ChatState copyWith({bool? loading, List<Message>? items, String? insertedKey}) => ChatState(
    loading: loading ?? this.loading,
    items: items ?? this.items,
    insertedKey: insertedKey,
  );
  @override List<Object?> get props => [loading, items, insertedKey];
}