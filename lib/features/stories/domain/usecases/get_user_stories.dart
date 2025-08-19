import 'package:whatsapp/features/stories/domain/entities/story.dart';
import 'package:whatsapp/features/stories/domain/repositories/stories_repository.dart';

class GetUserStories {
  GetUserStories(this._repo);
  final StoriesRepository _repo;

  Future<List<UserStories>> call() async {
    final items = await _repo.getStories();
    final map = <String, UserStories>{};
    for (final s in items) {
      final current = map[s.user];
      if (current == null) {
        map[s.user] = UserStories(user: s.user, avatar: s.avatar, media: List.of(s.media));
      } else {
        map[s.user] = UserStories(
          user: current.user,
          avatar: current.avatar,
          media: [...current.media, ...s.media],
        );
      }
    }
    // ترتيب اختياري: حسب طول الوسائط تنازلياً أو اتركه كما هو
    return map.values.toList();
  }
}
