import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storiesFavoriteProvider = StreamProvider.autoDispose<List<StoryModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('stories')
      .where(storyFavouritesListKey, arrayContains: FirebaseAuth.instance.currentUser!.uid) // Only get documents where storyData exists
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .where((story) => story.storyData != null && 
                          story.storyData!['title'] != null && 
                          story.storyData!['synopsis'] != null)
          .toList());
});

final storiesCurrentGameProvider = StreamProvider.autoDispose.family<List<StoryModel>, String>((ref, storyUid) {
  return FirebaseFirestore.instance
      .collection('stories')
      .where(storyUidKey, isEqualTo: storyUid) // Use the parameter here
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .where((story) =>
              story.storyData != null &&
              story.storyData!['title'] != null &&
              story.storyData!['synopsis'] != null)
          .toList());
});

final storiesByAuthorProvider = StreamProvider.autoDispose<List<StoryModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('stories')
      .where(storyAuthorUidKey, isEqualTo: FirebaseAuth.instance.currentUser!.uid) 
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .where((story) => story.storyData != null && 
                          story.storyData!['title'] != null && 
                          story.storyData!['synopsis'] != null)
          .toList());
});
