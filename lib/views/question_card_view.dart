import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:chaperone/models/story_model.dart';

class QuestionCard extends StatefulWidget {
  final StoryModel scenario;
  final VoidCallback onTimeUp;
  final String currentNode;
  final Function(String) onOptionSelected;

  const QuestionCard({
    super.key,
    required this.scenario,
    required this.onTimeUp,
    required this.currentNode,
    required this.onOptionSelected,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  double _progress = 1.0;
  final int _totalSeconds = 12;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Map<String, dynamic> get currentQuestion =>
      widget.scenario.storyData?[widget.currentNode] ?? {};

  @override
  void initState() {
    super.initState();
    startTimer();

    _animationController = AnimationController(
      duration: Duration(seconds: _totalSeconds),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_animationController);

    _animationController.forward();
  }

  void startTimer() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _progress -= 1 / (_totalSeconds * 20);
        if (_progress <= 0) {
          timer.cancel();
          widget.onTimeUp();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildOption(String optionKey, Map<String, dynamic> optionData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          widget.onOptionSelected(optionData['nextNode']);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            optionData['text'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        currentQuestion['imageUrl'] ?? widget.scenario.thumbnailUrl;
    final Map<String, dynamic> options = currentQuestion['options'] ?? {};

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Column(
            children: [
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.scenario.storyData![storyTitleKey],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2,
                        ),
                        child: ClipRRect(
                          child: LinearProgressIndicator(
                            value: _progress,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            minHeight: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            currentQuestion['question'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...options.entries.map((entry) => FadeInUpBig(
                              delay: const Duration(seconds: 10),
                              child: _buildOption(entry.key,
                                  entry.value as Map<String, dynamic>),
                            )),
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
}
