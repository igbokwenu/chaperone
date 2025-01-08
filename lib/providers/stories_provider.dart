import 'package:chaperone/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final storiesProvider = StreamProvider.autoDispose<List<StoryModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('stories')
      .where('storyData', isNull: false) // Only get documents where storyData exists
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .where((story) => story.storyData != null && 
                          story.storyData!['title'] != null && 
                          story.storyData!['synopsis'] != null)
          .toList());
});

