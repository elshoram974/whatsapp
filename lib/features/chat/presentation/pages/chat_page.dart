import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp/features/chat/presentation/widgets/message_bubble.dart';
import 'package:whatsapp/features/chat_list/data/sources/local_chat_list_source.dart';
import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({required this.chatId, super.key, this.chat});
  final String chatId;
  final ChatSummary? chat;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _controller = TextEditingController();
  ChatSummary? _meta;

  @override
  void initState() {
    super.initState();
    _meta = widget.chat;
    if (_meta == null) _loadMeta(); // fallback للديب لينك
    context.read<ChatBloc>().add(ChatOpened(widget.chatId));
  }

  Future<void> _loadMeta() async {
    try {
      final list = await LocalChatListSource().read();
      final found = list.firstWhere((e) => e.id == widget.chatId,
          orElse: () => throw Exception('not found'),);
      if (!mounted) return;
      setState(() => _meta = found.toDomain());
    } catch (_) {/* تجاهل */}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),),
              const SizedBox(width: 4),
              Hero(
                tag: 'chat-avatar-${widget.chatId}',
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: (_meta?.avatar != null)
                      ? AssetImage(_meta!.avatar)
                      : null,
                  child: (_meta?.avatar == null)
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _meta?.name ?? 'Chat',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: BlocListener<ChatBloc, ChatState>(
                listenWhen: (p, n) => n.insertedKey != null,
                listener: (_, s) =>
                    _listKey.currentState?.insertItem(s.items.length - 1),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (_, s) {
                    if (s.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AnimatedList(
                      key: _listKey,
                      initialItemCount: s.items.length,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index, animation) {
                        final item = s.items.reversed.toList()[index];
                        return SizeTransition(
                            sizeFactor: animation,
                            child: MessageBubble(item: item),);
                      },
                    );
                  },
                ),
              ),
            ),
            _InputBar(
              controller: _controller,
              onSend: (text) {
                if (text.trim().isEmpty) return;
                context
                    .read<ChatBloc>()
                    .add(ChatSend(widget.chatId, text.trim()));
                _controller.clear();
              },
            ),
          ],),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});
  final TextEditingController controller;
  final ValueChanged<String> onSend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: controller,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              hintText: 'type_message'.tr(),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                borderSide: BorderSide.none,
              ),
            ),
          ),),
          const SizedBox(width: 8),
          IconButton(
              icon: const Icon(Icons.send),
              color: AppColors.whatsappGreen,
              onPressed: () => onSend(controller.text),),
        ],
      ),
    );
  }
}
