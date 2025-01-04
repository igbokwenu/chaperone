import 'dart:convert';
import 'dart:io';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference storiesCollection =
      FirebaseFirestore.instance.collection('stories');

  Future<void> fetchUserCountryAndSaveToFirebase({
    String? existingCountry,
    String? docId,
  }) async {
    final response = await http.get(Uri.parse('http://ip-api.com/json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String country = data['country'];
      String state = data['regionName'];

      try {
        await storiesCollection.doc(docId ?? uid).update({
          userCountry: country,
          userState: state,
          userIpCountry: country,
          userIpState: state,
        });
      } on FirebaseException catch (e) {
        // Handle the error
        if (kDebugMode) {
          print('Error updating location fields: $e');
        }
      }
    }
  }

  Future<void> incrementUsageCount(String uid, String field) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    // Increment the field value by 1 using Firestore's FieldValue.increment()
    await userDoc.update({
      field: FieldValue.increment(1),
    });
  }

  Future<bool> checkUsageLimitExceeded(String uid) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshot = await userDoc.get();
    final data = snapshot.data();

    if (data != null) {
      final aiMediaUsageCount = data['aiMediaUsageCount'] ?? 0;
      final aiTextUsageCount = data['aiTextUsageCount'] ?? 0;
      final aiGeneralMediaUsageCount = data['aiGeneralMediaUsageCount'] ?? 0;
      final aiGeneralTextUsageCount = data['aiGeneralTextUsageCount'] ?? 0;

      // Check if any count exceeds 3
      return aiMediaUsageCount > 3 ||
          aiTextUsageCount > 3 ||
          aiGeneralMediaUsageCount > 3 ||
          aiGeneralTextUsageCount > 3;
    }

    return false;
  }

  Future<void> updateAnyStoriesData(
      {required String fieldName,
      required dynamic newValue,
      String? docId}) async {
    final userRef =
        FirebaseFirestore.instance.collection('stories').doc(docId ?? uid);

    // Get the current data
    final currentData = (await userRef.get()).data();

    if (currentData != null) {
      // Update the specified field with the new value
      currentData[fieldName] = newValue;

      // Update the document with the modified data
      await userRef.update(currentData);
    } else {
      // Handle the case where currentData is null (document not found)
      print('Document with ID $uid not found.');
    }
  }

  Future<void> createStoryDocument(
      {required Map<String, dynamic>? storyData}) async {
    try {
      // Fetch user location data
      final response = await http.get(Uri.parse('http://ip-api.com/json'));

      String country = '';
      String state = '';

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        country = data['country'] ?? '';
        state = data['regionName'] ?? '';
      }

      // Create a new document reference
      final newDocRef = storiesCollection.doc();

      // Set the document data, including country and state
      await newDocRef.set({
        storyUidKey: newDocRef.id,
        storyTitleKey: 'New Untitled Story',
        storyAuthorKey: '',
        storyThumbnailUrlKey: chaperoneLogoUrl512,
        storyIsVerifiedKey: false,
        storyViewsKey: 0,
        storyLikesKey: 0,
        storyCommentsKey: 0,
        storyIsBookmarkedKey: false,
        storySynopsisKey: '',
        storyQuestion1Key: '',
        storyQuestionOneImageUrlKey: '',
        storyAnswer1aKey: '',
        storyAnswer1bKey: '',
        storyLikeCountKey: 0,
        storyCommentCountKey: 0,
        storyPlayCountKey: 0,
        storyLikesUidKey: [],
        storyShareCountKey: 0,
        storyIsPublishedKey: false,
        storyIsApprovedKey: false,
        storyIsRejectedKey: false,
        storyIsTrendingKey: false,
        storyIsBasedOnTrueStoryKey: false,
        storyIsInspiredByTrueEventKey: false,
        storyIsForAdultKey: false,
        storyGameUidKey: '',
        storyDescriptionKey: '',
        storyAuthorNameKey: '',
        storyAuthorUidKey: uid,
        storyAuthorUsernameKey: '',
        storyAuthorDisplayNameKey: MyReusableFunctions.generateRandomUsername(),
        storyForMaleKey: false,
        storyForFemaleKey: false,
        storyFollowersKey: [],
        storyBookmarksListKey: [],
        storyFavouritesListKey: [],
        storyDataKey: storyData,
        userCountry: country,
        userState: state,
        userEmail: '',
        userProfilePicUrl: '',
        userIsAdmin: false,
        userIsBanned: false,
        userIsSuperAdmin: false,
        userIsPro: false,
        userAiTextUsageCount: 0,
        userAiGeneralMediaUsageCount: 0,
        userAiGeneralTextUsageCount: 0,
        userDevice: Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
                ? 'iOS'
                : 'Web',
        userTimeStamp: FieldValue.serverTimestamp(),
        usersMessagingToken: [],
      });

      print("Story document created with ID: ${newDocRef.id}");
    } catch (e) {
      if (kDebugMode) {
        print("Error creating story document: $e");
      }
    }
  }
}
