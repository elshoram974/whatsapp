import 'package:whatsapp/features/stories/domain/entities/story.dart';

class StoryViewerArgs {
  const StoryViewerArgs({required this.items, required this.initialIndex});
  final List<UserStories> items;
  final int initialIndex;
}
