import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:whatsapp/features/chat/data/sources/local_chat_source.dart';
import 'package:whatsapp/features/chat/domain/usecases/get_messages.dart';
import 'package:whatsapp/features/chat/domain/usecases/send_message.dart';
import 'package:whatsapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp/features/chat_list/data/repositories/chat_list_repository_impl.dart';
import 'package:whatsapp/features/chat_list/data/sources/local_chat_list_source.dart';
import 'package:whatsapp/features/chat_list/domain/entities/chat_summary.dart';
import 'package:whatsapp/features/chat_list/domain/usecases/get_chat_list.dart';
import 'package:whatsapp/features/chat_list/presentation/cubit/chat_list_cubit.dart';
import 'package:whatsapp/features/chat_list/presentation/pages/chat_list_page.dart';
import 'package:whatsapp/features/stories/data/repositories/stories_repository_impl.dart';
import 'package:whatsapp/features/stories/data/sources/local_stories_source.dart';
import 'package:whatsapp/features/stories/domain/entities/story_viewer_args.dart';
import 'package:whatsapp/features/stories/domain/usecases/get_user_stories.dart';
import 'package:whatsapp/features/stories/presentation/cubit/stories_cubit.dart';
import 'package:whatsapp/features/stories/presentation/pages/stories_page.dart';
import 'package:whatsapp/features/stories/presentation/pages/story_viewer_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => BlocProvider(
        create: (_) => ChatListCubit(
            GetChatList(ChatListRepositoryImpl(LocalChatListSource())),),
        child: const ChatListPage(),
      ),
    ),
    GoRoute(
      path: '/chat/:chatId',
      name: 'chat',
      pageBuilder: (context, state) {
        final chatId = state.pathParameters['chatId']!;
        final repo = ChatRepositoryImpl(LocalChatSource());
        final chatSummary = state.extra as ChatSummary?;
        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => ChatBloc(GetMessages(repo), SendMessage(repo)),
            child: ChatPage(chatId: chatId, chat: chatSummary),
          ),
          transitionsBuilder: (context, animation, secondary, child) {
            final slide = Tween(begin: const Offset(1, 0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(animation);
            return SlideTransition(
                position: slide,
                child: FadeTransition(opacity: animation, child: child),);
          },
        );
      },
    ),
    GoRoute(
      path: '/stories',
      name: 'stories',
      builder: (context, state) => BlocProvider(
        create: (_) => StoriesCubit(
            GetUserStories(StoriesRepositoryImpl(LocalStoriesSource())),),
        child: const StoriesPage(),
      ),
    ),
    GoRoute(
      path: '/stories/:storyId',
      name: 'storyViewer',
      pageBuilder: (context, state) {
        final args = state.extra! as StoryViewerArgs;
        return CustomTransitionPage(
          key: state.pageKey,
          child: StoryViewerPage(
              items: args.items, initialIndex: args.initialIndex,),
          transitionsBuilder: (context, animation, secondary, child) {
            final scale = Tween<double>(begin: 0.96, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),);
            return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: scale, child: child),);
          },
        );
      },
    ),
  ],
);
