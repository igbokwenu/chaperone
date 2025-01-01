import 'package:chaperone/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final chaperoneStoriesDataProvider =
//     StreamProvider.autoDispose.family<StoryModel?, String?>((ref, uid) {
//   if (uid == null) return Stream.value(null);

//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .snapshots()
//       .map((snapshot) => StoryModel.fromMap(snapshot.data()));
// });
