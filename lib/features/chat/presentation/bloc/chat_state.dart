part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.loading = false,
    this.items = const [],
    this.insertedKey,
    this.error,
  });
  final bool loading;
  final List<Message> items;
  final String? insertedKey;
  final String? error;

  ChatState copyWith({
    bool? loading,
    List<Message>? items,
    String? insertedKey,
    String? error,
  }) =>
      ChatState(
        loading: loading ?? this.loading,
        items: items ?? this.items,
        insertedKey: insertedKey,
        error: error,
      );

  @override
  List<Object?> get props => [loading, items, insertedKey, error];
}
