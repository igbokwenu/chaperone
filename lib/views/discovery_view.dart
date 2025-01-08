import 'dart:async';
import 'dart:math';

import 'package:chaperone/providers/stories_provider.dart';
import 'package:chaperone/views/settings_view.dart';
import 'package:chaperone/views/story_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late int fluctuatingNumber;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    final random = Random();
    fluctuatingNumber =
        random.nextInt(7001) + 2000; // Initial number between 2000 and 9000
    timer = Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      setState(() {
        fluctuatingNumber = random.nextInt(7001) + 2000; // Update number
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        fluctuatingNumber.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.tune),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final storiesAsyncValue = ref.watch(storiesProvider);

                return storiesAsyncValue.when(
                  data: (stories) {
                    if (stories.isEmpty) {
                      return const Center(
                        child: Text('No stories available'),
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
    );
  }
}
