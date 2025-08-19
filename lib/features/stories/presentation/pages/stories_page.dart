import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/stories/domain/entities/story_viewer_args.dart';
import 'package:whatsapp/features/stories/presentation/cubit/stories_cubit.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});
  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<StoriesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'tab_stories'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: BlocBuilder<StoriesCubit, StoriesState>(
                builder: (context, state) {
                  if (state is StoriesLoaded) {
                    final items = state.items;
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final u = items[i];
                        return ListTile(
                          leading: Hero(
                            tag: 'story-user-${u.user}',
                            child: CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(u.avatar),
                            ),
                          ),
                          title: Text(
                            u.user,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text('${u.media.length}'),
                          onTap: () => GoRouter.of(context).pushNamed(
                            'storyViewer',
                            pathParameters: {'storyId': u.user},
                            extra:
                                StoryViewerArgs(items: items, initialIndex: i),
                          ),
                        );
                      },
                    );
                  }
                  if (state is StoriesError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
