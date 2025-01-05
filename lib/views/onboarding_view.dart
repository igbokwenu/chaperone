import 'package:cached_network_image/cached_network_image.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<String> backgroundImages = [
    guyImageUrl,
    whiteLadyImageUrl,
    blackLadyImageUrl,
    dramaticImageUrl,
  ];

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _startImageTransition();
  }

  void _startImageTransition() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          currentImageIndex = (currentImageIndex + 1) % backgroundImages.length;
        });
        _startImageTransition();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with fade transition
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: CachedNetworkImage(
              key: ValueKey<int>(currentImageIndex),
              imageUrl: backgroundImages[currentImageIndex],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.black,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          // Content overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Step into a world where stories come alive. In Chaperone, immerse yourself in captivating narratives crafted by players worldwide. Experience interactive adventures based on real-life experiences or dive into imaginative realms created by our community.\n\nWhether you\'re sharing your own story or exploring others\', each journey offers a unique blend of storytelling and gameplay that bridges reality and imagination.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
