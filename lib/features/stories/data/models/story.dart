import 'package:whatsapp/features/stories/domain/entities/story.dart' as d;

class StoryModel {
  StoryModel({required this.id, required this.user, required this.avatar, required this.media});

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    id: json['id'] as String,
    user: json['user'] as String,
    avatar: json['avatar'] as String,
    media: (json['media'] as List).map((e)=> StoryMediaModel.fromJson(e as Map<String,dynamic>)).toList(),
  );
  final String id; final String user; final String avatar; final List<StoryMediaModel> media;

  d.Story toDomain()=> d.Story(id: id, user: user, avatar: avatar, media: media.map((m)=>m.toDomain()).toList());
}

class StoryMediaModel {
  StoryMediaModel({required this.url, required this.type, required this.durationMs});

  factory StoryMediaModel.fromJson(Map<String, dynamic> json) => StoryMediaModel(
    url: json['url'] as String,
    type: json['type'] as String,
    durationMs: (json['durationMs'] as num).toInt(),
  );
  final String url; final String type; final int durationMs;

  d.StoryMedia toDomain()=> d.StoryMedia(url: url, type: type, durationMs: durationMs);
}