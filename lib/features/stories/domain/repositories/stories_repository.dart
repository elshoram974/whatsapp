import 'package:whatsapp/features/stories/domain/entities/story.dart';
abstract class StoriesRepository { Future<List<Story>> getStories(); }