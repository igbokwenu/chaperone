import 'package:chaperone/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chaperoneUserDataProvider =
    StreamProvider.autoDispose.family<ChaperoneUserData?, String?>((ref, uid) {
  if (uid == null) return Stream.value(null);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((snapshot) => ChaperoneUserData.fromMap(snapshot.data()));
});
