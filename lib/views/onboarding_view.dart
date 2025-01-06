import 'package:cached_network_image/cached_network_image.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/utils/auth_buttons.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  final List<String> backgroundImages = [
    guyImageUrl,
    whiteLadyImageUrl,
    blackLadyImageUrl,
    dramaticImageUrl,
  ];

  late AnimationController _controller;
  late Animation<double> _animation;
  int currentImageIndex = 0;
  int nextImageIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          currentImageIndex = nextImageIndex;
          nextImageIndex = (nextImageIndex + 1) % backgroundImages.length;
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) _controller.forward();
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      body: Stack(
        children: [
          // Background images with crossfade
          Stack(
            children: [
              Image.network(
                backgroundImages[currentImageIndex],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.black,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black,
                    child: const Icon(Icons.error),
                  );
                },
              ),
              Opacity(
                opacity: _animation.value,
                child: Image.network(
                  backgroundImages[nextImageIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.black,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
              // Dark overlay for better text readability
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Chaperone',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "A world where stories come alive through captivating narratives and interactive adventures, blurring the lines between reality and imagination as you share your own journey or explore those crafted by a global community of players.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                      shadows: const [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () async {
                      if (!authService.isUserLoggedIn()) {
                        MyReusableFunctions.showCustomToast(
                            description:
                                "Setting up your stage. Please wait...");
                        await authService.signInAnonymously();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const AuthButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
