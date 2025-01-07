import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:chaperone/services/audio_manager.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:chaperone/models/story_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionCard extends ConsumerStatefulWidget {
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
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard>
    with TickerProviderStateMixin {
  late Timer _timer;
  double _progress = 1.0;
  final int _totalSeconds = 8;
  bool _showOptions = false;

  // Animation controllers
  late AnimationController _scaleController;
  late AnimationController _optionsController;

  // Animations
  late Animation<double> _scaleAnimation;
  late Animation<double> _optionsAnimation;

  Map<String, dynamic> get currentQuestion =>
      widget.scenario.storyData?[widget.currentNode] ?? {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Scale animation for the image
    _scaleController = AnimationController(
      duration: Duration(seconds: _totalSeconds),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_scaleController);

    // Options animation
    _optionsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _optionsAnimation = CurvedAnimation(
      parent: _optionsController,
      curve: Curves.easeInOut,
    );

    // Start initial animations
    _scaleController.forward();
    startTimer();
  }

  void _skipAnimations() {
    _timer.cancel();
    _scaleController.forward(from: 1.0);
    setState(() {
      _progress = 0.0;
      _showOptions = true;
    });
    _optionsController.forward();
    widget.onTimeUp();
  }

  void _resetAnimations() {
    setState(() {
      _progress = 1.0;
      _showOptions = false;
    });

    _timer.cancel();
    startTimer();

    _scaleController.reset();
    _scaleController.forward();

    _optionsController.reset();
  }

  void startTimer() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _progress -= 1 / (_totalSeconds * 20);

        // Show options when progress bar completes
        if (_progress <= 0) {
          timer.cancel();
          _showOptions = true;
          _optionsController.forward();
          widget.onTimeUp();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scaleController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  Widget _buildOption(String optionKey, Map<String, dynamic> optionData) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(_optionsAnimation),
      child: FadeTransition(
        opacity: _optionsAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              ref.read(audioControllerProvider.notifier).playSoundEffect();
              _resetAnimations();
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
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Opacity(
      opacity: _showOptions ? 0.0 : 1.0, // Hide when options are shown
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 16), // Add spacing between skip button and question
        child: TextButton(
          onPressed: _showOptions ? null : _skipAnimations,
          style: TextButton.styleFrom(
            backgroundColor: Colors.black26,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.fast_forward,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        currentQuestion['imageUrl'] ?? widget.scenario.questionOneImageUrl;
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
                              icon: const Icon(Icons.settings,
                                  color: Colors.white),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen()),
                              ),
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
                        Pulse(
                            delay: const Duration(milliseconds: 1500),
                            child:
                                _buildSkipButton()), // Skip button added here
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
                        if (_showOptions)
                          ...options.entries.map((entry) => _buildOption(
                              entry.key, entry.value as Map<String, dynamic>)),
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
