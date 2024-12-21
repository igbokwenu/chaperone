import 'package:chaperone/views/select_game_view.dart';
import 'package:flutter/material.dart';

class GameLandingPage extends StatefulWidget {
  const GameLandingPage({super.key});

  @override
  GameLandingPageState createState() => GameLandingPageState();
}

class GameLandingPageState extends State<GameLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E0FF), // Light blue
              Color(0xFFFFB74D), // Orange
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
                final isLandscape = MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height;

                return Container(
                  width: isLandscape
                      ? constraints.maxWidth * 0.8
                      : constraints.maxWidth,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: isLandscape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _buildTitleAndSubtitle(),
                            ),
                            Expanded(
                              child: _buildGameIconAndButton(),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTitleAndSubtitle(),
                            const SizedBox(height: 50),
                            _buildGameIconAndButton(),
                          ],
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Chaperone',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black26,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
        ),
        const Text(
          'Stories That Serve You',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildGameIconAndButton({
    String? imageUrl,
    double iconSize = 200,
    Color iconBackgroundColor = Colors.white,
    Color iconColor = const Color(0xFFB3E0FF),
    String buttonText = 'Start Game',
    Color buttonForegroundColor = const Color(0xFFB3E0FF),
    Color buttonBackgroundColor = Colors.white,
    double buttonFontSize = 24,
    EdgeInsets buttonPadding =
        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl ?? 'https://your-game-icon-url.com/icon.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: iconBackgroundColor,
                  child: Icon(
                    Icons.games,
                    size: iconSize / 2,
                    color: iconColor,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        ScaleTransition(
          scale: _pulseAnimation,
          child: ElevatedButton(
            onPressed: onPressed ??
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StoryCarousel()),
                  );
                },
            style: ElevatedButton.styleFrom(
              foregroundColor: buttonForegroundColor,
              backgroundColor: buttonBackgroundColor,
              padding: buttonPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: buttonFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
