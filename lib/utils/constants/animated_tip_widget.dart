import 'package:flutter/material.dart';

class AnimatedTipText extends StatefulWidget {
  const AnimatedTipText({super.key});

  @override
  State<AnimatedTipText> createState() => _AnimatedTipTextState();
}

class _AnimatedTipTextState extends State<AnimatedTipText> {
  final List<String> tips = [
    "Tip: Craft a vivid and detailed prompt to unlock a rich and captivating tale. Get creative and have fun!",
    "Pro Tip: Add depth and nuance to your prompt to unleash a truly enchanting story."
  ];

  int currentTipIndex = 0;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _startTipAnimation();
  }

  void _startTipAnimation() {
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          isVisible = false;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              currentTipIndex = (currentTipIndex + 1) % tips.length;
              isVisible = true;
            });
            _startTipAnimation();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Text(
        tips[currentTipIndex],
        textAlign: TextAlign.center,
      ),
    );
  }
}
