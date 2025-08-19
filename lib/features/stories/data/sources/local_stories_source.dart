import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:whatsapp/features/stories/data/models/story.dart';

class LocalStoriesSource {
  Future<List<StoryModel>> read() async {
    final str = await rootBundle.loadString('assets/mock/stories.json');
    final list = (json.decode(str) as List).cast<Map<String, dynamic>>();
    return list.map(StoryModel.fromJson).toList();
  }
}