import 'package:chaperone/test2.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Mock data model
class StoryScenario {
  final String id;
  final String title;
  final String author;
  final String thumbnailUrl;
  final bool isVerified;
  final int views;
  final int likes;
  final int comments;
  final bool isBookmarked;
  final String? description;

  StoryScenario(
      {required this.id,
      required this.title,
      required this.author,
      required this.thumbnailUrl,
      required this.isVerified,
      required this.views,
      required this.likes,
      required this.comments,
      this.isBookmarked = false,
      this.description});
}

// Mock data
List<StoryScenario> mockScenarios = [
  StoryScenario(
    id: '1',
    title: 'Job Interview',
    author: 'By Yuhang Han',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage9.png?alt=media&token=3325b642-0ccf-419f-b6f7-2453a3844359',
    isVerified: true,
    views: 32500,
    likes: 27800,
    comments: 6780,
    isBookmarked: false,
    description:
        'How do you handle workplace discrimination in a job interview.',
  ),
  StoryScenario(
    id: '2',
    title: 'He Was A Vampire',
    author: 'By Jonathan Stiller',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage10.png?alt=media&token=73ff6db0-8a45-421f-8774-a73e3ac37749',
    isVerified: true,
    views: 28400,
    likes: 24300,
    comments: 5430,
    isBookmarked: true,
    description:
        'He is a vampire, but he is desperately in love with me. Can his love for me overcome his beastly thirst for blood?',
  ),
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    child: const Row(
                      children: [
                        Icon(Icons.trending_up, size: 16),
                        SizedBox(width: 4),
                        Text('3,580'),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.tune),
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockScenarios.length,
                itemBuilder: (context, index) {
                  final scenario = mockScenarios[index];
                  return StoryCard(scenario: scenario);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pinkAccent,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final StoryScenario scenario;

  const StoryCard({
    super.key,
    required this.scenario,
  });

  @override
  Widget build(BuildContext context) {
    const double kDefaultPadding = 12;
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'story-image-${scenario.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  child: Image.network(
                    scenario.thumbnailUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    scenario.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            scenario.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        scenario.author,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildGlossyStat(Icons.visibility_outlined,
                            _formatNumber(scenario.views)),
                        const SizedBox(width: 16),
                        _buildGlossyStat(Icons.favorite_border,
                            _formatNumber(scenario.likes)),
                        const SizedBox(width: 16),
                        _buildGlossyStat(Icons.chat_bubble_outline,
                            _formatNumber(scenario.comments)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoryPreviewCard(scenario: scenario),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Play'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlossyStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white70,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}

class StoryPreviewCard extends StatelessWidget {
  final StoryScenario scenario;

  const StoryPreviewCard({
    super.key,
    required this.scenario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top app bar with back button and title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Center(
                    child: Text(
                      scenario.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          // Main content
          Expanded(
            child: Stack(
              children: [
                // Hero image
                Hero(
                  tag: 'story-image-${scenario.id}',
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: Image.network(
                        scenario.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Bookmark button overlay
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      scenario.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                // Author info and social buttons
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author row with avatar
                      Row(
                        children: [
                          // Author avatar
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                'Author',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            scenario.author,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.twitter,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.instagram,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Story description
                      Text(
                        scenario.description ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Stats bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildStat(Icons.visibility_outlined,
                                _formatNumber(scenario.views)),
                            const SizedBox(width: 16),
                            _buildStat(Icons.favorite_border,
                                _formatNumber(scenario.likes)),
                            const SizedBox(width: 16),
                            _buildStat(Icons.chat_bubble_outline,
                                _formatNumber(scenario.comments)),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Start Game'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white70,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
