import 'package:chaperone/providers/dynamic_stories_provider.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/story_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaperone/models/story_model.dart';



  class DynamicStoriesView extends ConsumerWidget {
  final String? currentGameAuthorUid;
  final String? currentGameStoryUid;
  final String? favoriteUserId;
  final String? authorId;
  final String viewTitle;

  const DynamicStoriesView({
    Key? key,
    this.currentGameAuthorUid,
    this.currentGameStoryUid,
    this.favoriteUserId,
    this.authorId,
    required this.viewTitle,
  }) : super(key: key);

  Map<String, dynamic> _buildParams() {
    final params = <String, dynamic>{};
    
    if (currentGameAuthorUid != null && currentGameStoryUid != null) {
      params[kDynamicStoriesParamCurrentGame] = {
        kDynamicStoriesParamAuthorUid: currentGameAuthorUid,
        kDynamicStoriesParamStoryUid: currentGameStoryUid,
      };
    }
    
    if (favoriteUserId != null) {
      params[kDynamicStoriesParamIsFavorite] = favoriteUserId;
    }
    
    if (authorId != null) {
      params[kDynamicStoriesParamByAuthor] = authorId;
    }
    
    return params;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsyncValue = ref.watch(dynamicStoriesProvider(_buildParams()));

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  viewTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Implement filter dialog if needed
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: storiesAsyncValue.when(
              data: (stories) {
                if (stories.isEmpty) {
                  return const Center(
                    child: Text(kDynamicStoriesDefaultEmptyMessage),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return StoryCard(
                      scenario: story,
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}