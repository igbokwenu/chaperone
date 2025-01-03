import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/views/result_view.dart';
import 'package:flutter/material.dart';

class StoryGameScreen extends StatefulWidget {
  final StoryModel story;

  const StoryGameScreen({Key? key, required this.story}) : super(key: key);

  @override
  _StoryGameScreenState createState() => _StoryGameScreenState();
}

class _StoryGameScreenState extends State<StoryGameScreen> {
  String currentNode = 'start';
  List<String> history = [];
  int questionCount = 0;

  @override
  Widget build(BuildContext context) {
    final storyData = widget.story.storyData;
    final currentQuestion = storyData?[currentNode];

    if (currentQuestion == null) {
      return ResultView(
        scenario: widget.story,
        pathTaken: [],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (history.isNotEmpty) {
              setState(() {
                currentNode = history.removeLast();
                questionCount--;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: questionCount / 4,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 20),

              // Question text
              Text(
                currentQuestion['question'],
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Image placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Image: ${currentQuestion['imagePrompt']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Options
              ...(currentQuestion['options'] as Map<String, dynamic>)
                  .entries
                  .map(
                    (option) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () =>
                            _handleChoice(option.value['nextNode']),
                        child: Text(
                          option.value['text'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleChoice(String nextNode) {
    if (questionCount >= 4) {
      // Show end game dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Story Complete'),
          content: const Text('You have reached the end of your journey.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      history.add(currentNode);
      currentNode = nextNode;
      questionCount++;
    });
  }
}
