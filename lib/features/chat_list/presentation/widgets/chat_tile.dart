import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({required this.chat, required this.onTap, super.key});
  final ChatSummary chat; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Hero(
        tag: 'chat-avatar-${chat.id}',
        child: CircleAvatar(radius: 24, backgroundImage: CachedNetworkImageProvider(chat.avatar)),
      ),
      title: Text(chat.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
      subtitle: Text(chat.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(DateFormat('jm').format(chat.lastTime), style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12)),
          if (chat.unread > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: Text('${chat.unread}', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}