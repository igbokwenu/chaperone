import 'package:chaperone/providers/stories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryDisplay extends ConsumerWidget {
  final String uid;

  const StoryDisplay({required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyAsync = ref.watch(chaperoneStoriesDataProvider(uid));

    return storyAsync.when(
      data: (story) {
        if (story == null || story.storyData == null) {
          return const Center(child: Text('No story data available'));
        }

        final title = story.storyData?['title'] as String;
        final synopsis = story.storyData?['synopsis'] as String;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  synopsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading story: $error'),
      ),
    );
  }
}
