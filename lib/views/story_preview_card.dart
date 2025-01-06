import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/services/database_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/question_card_view.dart';
import 'package:chaperone/views/result_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryPreviewCard extends StatelessWidget {
  final StoryModel scenario;

  const StoryPreviewCard({
    super.key,
    required this.scenario,
  });

  @override
  Widget build(BuildContext context) {
    final databaseService = DatabaseService(uid: scenario.storyUid!);
    void startGame(BuildContext context) async {
      await databaseService.updateAnyStoriesData(
        fieldName: storyPlayCountKey,
        newValue: FieldValue.increment(1),
      );
      // Start with the 'start' node of the story
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _GameFlow(scenario: scenario),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
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
                      scenario.storyData![storyTitleKey],
                      style: const TextStyle(
                        fontSize: 15,
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
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: 'story-image-${scenario.storyUid}',
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
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                            scenario.authorDisplayname!,
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
                      Text(
                        scenario.storyData![storySynopsisKey],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                                _formatNumber(scenario.favouritesList!.length)),
                            const SizedBox(width: 16),
                            _buildStat(Icons.play_circle,
                                _formatNumber(scenario.playCount!)),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => startGame(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Start',
                                style: TextStyle(color: Colors.white),
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

// New StatefulWidget to manage the game flow
class _GameFlow extends StatefulWidget {
  final StoryModel scenario;

  const _GameFlow({required this.scenario});

  @override
  State<_GameFlow> createState() => _GameFlowState();
}

class _GameFlowState extends State<_GameFlow> {
  String currentNode = 'start';
  List<String> pathTaken = [];

  void _handleOptionSelected(String nextNode) {
    if (nextNode == 'end') {
      // Game is complete, show the result
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultView(
            scenario: widget.scenario,
            pathTaken: pathTaken,
          ),
        ),
      );
    } else {
      setState(() {
        pathTaken.add(currentNode);
        currentNode = nextNode;
      });
    }
  }

  void _handleTimeUp() {
    // showModalBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.transparent,
    //   builder: (BuildContext context) {
    //     final currentQuestionData = widget.scenario.storyData?[currentNode] ?? {};
    //     final options = currentQuestionData['options'] as Map<String, dynamic>? ?? {};

    //     return Container(
    //       padding: const EdgeInsets.all(24),
    //       decoration: BoxDecoration(
    //         color: Colors.white.withOpacity(0.9),
    //         borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(32),
    //           topRight: Radius.circular(32),
    //         ),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black.withOpacity(0.2),
    //             blurRadius: 10,
    //             spreadRadius: 2,
    //           )
    //         ],
    //       ),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Container(
    //             width: 40,
    //             height: 4,
    //             margin: const EdgeInsets.only(bottom: 20),
    //             decoration: BoxDecoration(
    //               color: Colors.grey.withOpacity(0.3),
    //               borderRadius: BorderRadius.circular(2),
    //             ),
    //           ),
    //           ...options.entries.map((entry) => Padding(
    //             padding: const EdgeInsets.only(bottom: 16.0),
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 _handleOptionSelected(entry.value['nextNode']);
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 minimumSize: const Size(double.infinity, 56),
    //                 backgroundColor: Colors.white.withOpacity(0.9),
    //                 elevation: 8,
    //                 shadowColor: Colors.blue.withOpacity(0.5),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //               ),
    //               child: Text(
    //                 entry.value['text'],
    //                 style: const TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //             ),
    //           )).toList(),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionCard(
      scenario: widget.scenario,
      currentNode: currentNode,
      onTimeUp: _handleTimeUp,
      onOptionSelected: _handleOptionSelected,
    );
  }
}
