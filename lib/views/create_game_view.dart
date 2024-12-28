import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/views/home_view.dart';
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
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const HomeView(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
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
                            // Background Image with Animation
                            SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: _AnimatedBackgroundImage(
                                imageUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage11.png?alt=media&token=971206dc-72f9-4d68-840c-eeffee94da73',
                              ),
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
                                  onPressed: () {
                                    MyReusableFunctions.showCustomToast(
                                      description: 'Coming Soon. Stay Tuned!',
                                    );
                                  },
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
                                    'Author',
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

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          createGamePitchText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        MyReusableFunctions.showCustomToast(
                          description: 'Coming Soon. Stay Tuned!',
                        );
                      },
                      child: _AnimatedButtonText(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    )
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

class _AnimatedBackgroundImage extends StatefulWidget {
  final String imageUrl;

  const _AnimatedBackgroundImage({required this.imageUrl});

  @override
  _AnimatedBackgroundImageState createState() =>
      _AnimatedBackgroundImageState();
}

class _AnimatedBackgroundImageState extends State<_AnimatedBackgroundImage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _positionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat(reverse: true);

    _positionController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_scaleController);

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 30.0,
    ).animate(_positionController);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _positionController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.translate(
            offset: Offset(0, -_positionAnimation.value),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity,
            ),
          ),
        );
      },
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
        'Create Your Game',
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
