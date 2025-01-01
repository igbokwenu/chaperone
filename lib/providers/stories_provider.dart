
// final chaperoneStoriesDataProvider =
//     StreamProvider.autoDispose.family<StoryModel?, String?>((ref, uid) {
//   if (uid == null) return Stream.value(null);

//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .snapshots()
//       .map((snapshot) => StoryModel.fromMap(snapshot.data()));
// });
