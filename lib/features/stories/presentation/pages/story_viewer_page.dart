import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/stories/domain/entities/story.dart';

class StoryViewerPage extends StatefulWidget {
  const StoryViewerPage({required this.items, required this.initialIndex, super.key});
  final List<UserStories> items;
  final int initialIndex;
  @override State<StoryViewerPage> createState()=>_StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> with TickerProviderStateMixin {
  late final PageController _users;
  int _userIndex = 0;
  int _mediaIndex = 0;
  AnimationController? _a;

  UserStories get _currentUser => widget.items[_userIndex];

  @override void initState(){
    super.initState();
    _userIndex = widget.initialIndex;
    _users = PageController(initialPage: _userIndex);
    _startForCurrent();
  }
  @override void dispose(){ _a?.dispose(); _users.dispose(); super.dispose(); }

  void _startForCurrent(){
    _a?.dispose();
    final d = _currentUser.media[_mediaIndex].durationMs;
    _a = AnimationController(vsync: this, duration: Duration(milliseconds: d))
      ..addListener(()=> setState((){}))
      ..addStatusListener((s){ if (s==AnimationStatus.completed) _nextMedia(); })
      ..forward();
    setState((){});
  }

  void _pause()=> _a?.stop();
  void _resume()=> _a?.forward();

  void _nextMedia(){
    final total = _currentUser.media.length;
    if (_mediaIndex < total-1) {
      _mediaIndex++;
      _startForCurrent();
    } else {
      _nextUser();
    }
  }

  void _prevMedia(){
    if (_mediaIndex > 0) {
      _mediaIndex--;
      _startForCurrent();
    } else {
      _prevUser();
    }
  }

  void _nextUser(){
    if (_userIndex < widget.items.length-1) {
      _users.nextPage(duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
    } else {
      if (mounted) context.pop();
    }
  }

  void _prevUser(){
    if (_userIndex > 0) {
      _users.previousPage(duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
    }
  }

  void _onUserChanged(int index){
    _userIndex = index;
    _mediaIndex = 0;
    _startForCurrent();
  }

  @override
  Widget build(BuildContext context){
    return PopScope(
      child: GestureDetector(
        onLongPressStart: (_) => _pause(),
        onLongPressEnd:   (_) => _resume(),
        onTapUp: (d){
          final w = MediaQuery.of(context).size.width;
          if (d.localPosition.dx > w/2) { _nextMedia(); } else { _prevMedia(); }
        },
        child: Stack(children:[
          // صفحات المستخدمين
          PageView.builder(
            controller: _users,
            onPageChanged: _onUserChanged,
            itemCount: widget.items.length,
            itemBuilder: (context, i){
              final u = widget.items[i];
              final showIndex = (i == _userIndex) ? _mediaIndex : 0;
              return Stack(children: [
                Positioned.fill(
                  child: Image.asset(u.media[showIndex].url, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Hero(tag: 'story-user-${u.user}', child: const ColoredBox(color: Colors.transparent)),
                ),
              ],);
            },
          ),
          // شريط التقدم للمستخدم الحالي
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: List.generate(_currentUser.media.length, (i){
                      final v = i < _mediaIndex ? 1.0 : i > _mediaIndex ? 0.0 : (_a?.value ?? 0.0);
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: i==_currentUser.media.length-1?0:4),
                          height: 2.5,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: LinearProgressIndicator(
                            value: v,
                            backgroundColor: Colors.transparent,
                            minHeight: 2.5,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(radius: 14, backgroundImage: AssetImage(_currentUser.avatar)),
                      const SizedBox(width: 8),
                      Text(_currentUser.user, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
