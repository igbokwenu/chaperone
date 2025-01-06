import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/providers/dynamic_stories_provider.dart';
import 'package:chaperone/providers/stories_provider.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/create_game_onboarding_view.dart';
import 'package:chaperone/views/story_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicStoriesView extends StatelessWidget {
  final String providerKey;
  final String? storyUid;

  const DynamicStoriesView(
      {super.key, required this.providerKey, this.storyUid});

  @override
  Widget build(BuildContext context) {
    // Function to get the correct provider based on the providerKey
    AutoDisposeStreamProvider<List<StoryModel>> getFruit(String providerKey) {
      switch (providerKey) {
        case kIsFavorite:
          return storiesFavoriteProvider;
        case kByAuthor:
          return storiesByAuthorProvider;
        case kCurrentGame:
          //This is an unsafe implementation but I'm in a hurry to finish this 🤓
          return storiesCurrentGameProvider(storyUid!);
        default:
          return storiesProvider;
      }
    }

    String dynamicTitle(String providerKey) {
      switch (providerKey) {
        case kIsFavorite:
          return 'Favorites';
        case kByAuthor:
          return 'Stories By You';
        case kCurrentGame:
          return 'Preview Your Game';
        default:
          return 'Chaperone';
      }
    }

    String dynamicNoStoryText(String providerKey) {
      switch (providerKey) {
        case kIsFavorite:
          return 'You have not yet added any stories to your favorites';
        case kByAuthor:
          return 'You have not yet created any stories';
        case kCurrentGame:
          return 'Something went wrong when creating your game. Perharps your story was too dark for our AI 💀';
        default:
          return 'Chaperone';
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            dynamicTitle(providerKey),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  // Use the selected provider based on providerKey
                  final storiesAsyncValue = ref.watch(getFruit(providerKey));

                  return storiesAsyncValue.when(
                    data: (stories) {
                      if (stories.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              spacing: 15,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dynamicNoStoryText(providerKey),
                                  textAlign: TextAlign.center,
                                ),
                                if (providerKey == kByAuthor)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateGameOnboardingView()),
                                      );
                                    },
                                    child: const Text('Create a Story'),
                                  ),
                              ],
                            ),
                          ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
