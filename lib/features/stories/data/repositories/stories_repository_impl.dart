import 'package:whatsapp/features/stories/data/sources/local_stories_source.dart';
import 'package:whatsapp/features/stories/domain/entities/story.dart';
import 'package:whatsapp/features/stories/domain/repositories/stories_repository.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  StoriesRepositoryImpl(this._src); final LocalStoriesSource _src;
  @override Future<List<Story>> getStories() async => (await _src.read()).map((e)=>e.toDomain()).toList();
}