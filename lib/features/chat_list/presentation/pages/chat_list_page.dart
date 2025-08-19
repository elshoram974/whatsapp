import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/chat_list/presentation/cubit/chat_list_cubit.dart';
import 'package:whatsapp/features/chat_list/presentation/widgets/chat_tile.dart';
import 'package:whatsapp/features/stories/data/repositories/stories_repository_impl.dart';
import 'package:whatsapp/features/stories/data/sources/local_stories_source.dart';
import 'package:whatsapp/features/stories/domain/usecases/get_user_stories.dart';
import 'package:whatsapp/features/stories/presentation/cubit/stories_cubit.dart';
import 'package:whatsapp/features/stories/presentation/pages/stories_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});
  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int screen = 0;
  @override
  void initState() {
    super.initState();
    context.read<ChatListCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        if(screen != 0) changePage(0);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('appName'.tr())),
        body: _list[screen].screen,
        bottomNavigationBar: NavigationBar(
          selectedIndex: screen,
          destinations: List.generate(
            _list.length,
            (index) {
              final item = _list[index];
              return NavigationDestination(
                icon: Icon(item.icon),
                label: item.label,
              );
            },
          ),
          onDestinationSelected: changePage,
        ),
      ),
    );
  }

  void changePage(int value) {
    screen = value;
    setState(() {});
  }
}

final List<HomeDataModel> _list = [
  HomeDataModel(
    label: 'tab_chats'.tr(),
    icon: Icons.chat_bubble_outline,
    screen: const ChatsScreen(),
  ),
  HomeDataModel(
    label: 'tab_stories'.tr(),
    icon: Icons.history,
    screen: BlocProvider(
      create: (_) => StoriesCubit(
        GetUserStories(StoriesRepositoryImpl(LocalStoriesSource())),
      ),
      child: const StoriesPage(),
    ),
  ),
];

class HomeDataModel {
  const HomeDataModel(
      {required this.label, required this.icon, required this.screen});

  final String label;
  final IconData icon;
  final Widget screen;
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListCubit, ChatListState>(
      buildWhen: (p, n) => n is! ChatListLoading,
      builder: (context, state) {
        if (state is ChatListLoaded) {
          return ListView.separated(
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final c = state.items[i];
              return ChatTile(
                key: ValueKey('chat_${c.id}'),
                chat: c,
                onTap: () => GoRouter.of(context).pushNamed(
                  'chat',
                  pathParameters: {'chatId': c.id},
                  extra: c,
                ),
              );
            },
          );
        }
        if (state is ChatListError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
