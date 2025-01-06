import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



  final dynamicStoriesProvider = StreamProvider.autoDispose.family<List<StoryModel>, Map<String, dynamic>>(
  (ref, params) {
    Query query = FirebaseFirestore.instance.collection(kDynamicStoriesCollectionName);
    
    // Base filter for valid stories
    query = query.where(kDynamicStoriesFieldStoryData, isNull: false);

    // Apply filters based on parameters
    if (params.containsKey(kDynamicStoriesParamCurrentGame)) {
      final Map<String, String> gameParams = params[kDynamicStoriesParamCurrentGame];
      query = query
        .where(kDynamicStoriesParamAuthorUid, isEqualTo: gameParams[kDynamicStoriesParamAuthorUid])
        .where(kDynamicStoriesParamStoryUid, isEqualTo: gameParams[kDynamicStoriesParamStoryUid]);
    }
    
    if (params.containsKey(kDynamicStoriesParamIsFavorite)) {
      final String userId = params[kDynamicStoriesParamIsFavorite];
      query = query.where(kDynamicStoriesFieldFavoritesList, arrayContains: userId);
    }
    
    if (params.containsKey(kDynamicStoriesParamByAuthor)) {
      final String authorId = params[kDynamicStoriesParamByAuthor];
      query = query.where(kDynamicStoriesParamAuthorUid, isEqualTo: authorId);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => StoryModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((story) => story.storyData != null && 
                        story.storyData!['title'] != null && 
                        story.storyData!['synopsis'] != null)
        .toList());
  },
);


