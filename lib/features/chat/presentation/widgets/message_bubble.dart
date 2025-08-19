import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.item, super.key});
  final Message item;
  @override
  Widget build(BuildContext context) {
    final isMe = item.fromMe;
    final theme = Theme.of(context);
    final color = Theme.of(context).brightness == Brightness.dark
        ? (isMe ? AppColors.senderBubbleDark.withOpacity(0.6) : AppColors.receiverBubbleDark)
        : (isMe ? AppColors.senderBubbleLight : AppColors.receiverBubbleLight);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(item.text),
            const SizedBox(height: 4),
            Text(DateFormat('jm').format(item.time), style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}