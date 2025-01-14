import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/utils/reusable_widgets.dart';
import 'package:chaperone/views/create_game_view.dart';
import 'package:chaperone/views/home_view.dart';
import 'package:flutter/material.dart';

class CreateGameOnboardingView extends StatelessWidget {
  const CreateGameOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'The World Awaits',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top Navigation Bar
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 16.0,
                    //     vertical: 8.0,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       // IconButton(
                    //       //   icon: const Icon(Icons.arrow_back),
                    //       //   onPressed: () {

                    //       //   },
                    //       // ),
                    //       const Spacer(),
                    //       const Text(
                    //         'The World Awaits',
                    //         style: TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       const Spacer(),
                    //       IconButton(
                    //         icon: const Icon(Icons.more_horiz),
                    //         onPressed: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),

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
                            const SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: _AnimatedBackgroundImage(
                                imageUrl: createGameImageUrl,
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
                                  onPressed: () async {
                                    if (!authService.isUserLoggedIn()) {
                                      MyReusableFunctions.showCustomToast(
                                          description:
                                              "Setting up your stage 🥰");
                                      await authService.signInAnonymously();
                                    }
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateGameView()),
                                      );
                                    }
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
                                    child: const AnimatedButtonText(),
                                  ),
                                ),
                              ),
                            ),

                            // Author Info
                            // Positioned(
                            //   bottom: 16,
                            //   left: 16,
                            //   child: Row(
                            //     children: [
                            //       const CircleAvatar(
                            //         radius: 12,
                            //         backgroundColor: Colors.white,
                            //       ),
                            //       const SizedBox(width: 8),
                            //       Text(
                            //         'Author',
                            //         style: TextStyle(
                            //           color: Colors.white.withOpacity(0.9),
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                          MyReusableFunctions.showCustomDialog(
                              context: context,
                              message: whyCreateGameText,
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!authService.isUserLoggedIn()) {
                                      MyReusableFunctions.showCustomToast(
                                          description:
                                              "Setting up your account");
                                      await authService.signInAnonymously();
                                    }
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateGameView()),
                                      );
                                    }
                                  },
                                  child: const AnimatedButtonText(),
                                ),
                              ]);
                        },
                        child: const Text(
                          'Why Create A Game?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        )),

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
      duration: const Duration(seconds: 25), // Reduced from 40 to 25 seconds
      vsync: this,
    )..repeat(reverse: true);

    _positionController = AnimationController(
      duration: const Duration(seconds: 25), // Reduced from 40 to 25 seconds
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
