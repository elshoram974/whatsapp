import 'package:equatable/equatable.dart';

class Story extends Equatable {
  const Story({required this.id, required this.user, required this.avatar, required this.media});
  final String id;
  final String user;
  final String avatar;
  final List<StoryMedia> media;
  @override List<Object?> get props=>[id,user,avatar,media];
}

class StoryMedia extends Equatable {
  const StoryMedia({required this.url, required this.type, required this.durationMs});
  final String url;
  final String type;
  final int durationMs;
  @override List<Object?> get props=>[url,type,durationMs];
}

/// مجموعة قصص لمستخدم واحد (كل الوسائط مدموجة بالتسلسل)
class UserStories extends Equatable {
  const UserStories({required this.user, required this.avatar, required this.media});
  final String user;
  final String avatar;
  final List<StoryMedia> media; // ندمج كل وسائط المستخدم هنا
  @override List<Object?> get props => [user, avatar, media];
}
