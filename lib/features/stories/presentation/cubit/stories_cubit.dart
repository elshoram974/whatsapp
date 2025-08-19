import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/stories/domain/entities/story.dart';
import 'package:whatsapp/features/stories/domain/usecases/get_user_stories.dart';

sealed class StoriesState {}
class StoriesLoading extends StoriesState {}
class StoriesLoaded extends StoriesState { StoriesLoaded(this.items); final List<UserStories> items; }
class StoriesError extends StoriesState { StoriesError(this.message); final String message; }

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit(this._get): super(StoriesLoading());
  final GetUserStories _get;
  Future<void> load() async {
    try { emit(StoriesLoaded(await _get())); }
    catch(e){ emit(StoriesError(e.toString())); }
  }
}
