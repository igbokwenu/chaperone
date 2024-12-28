import 'package:chaperone/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class CreateGameView extends StatelessWidget {
  const CreateGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top Navigation Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          const Text(
                            'The World Awaits',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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

                    // Game Card
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Background Image
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage11.png?alt=media&token=971206dc-72f9-4d68-840c-eeffee94da73',
                              fit: BoxFit.cover,
                              height: 400,
                              width: double.infinity,
                            ),

                            // Gradient Overlay
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),

                            // Create Game Button
                            Positioned(
                              bottom: 60,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: _AnimatedButtonText(),
                                  ),
                                ),
                              ),
                            ),

                            // Author Info
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Name of the Author',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // About Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          createGamePitchText,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedButtonText extends StatefulWidget {
  @override
  _AnimatedButtonTextState createState() => _AnimatedButtonTextState();
}

class _AnimatedButtonTextState extends State<_AnimatedButtonText> {
  bool _showFirstText = true;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showFirstText = !_showFirstText;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const Text(
        'Create A New Game',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      secondChild: const Text(
        'Tell Your Story',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      crossFadeState:
          _showFirstText ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }
}
