// main.dart
import 'package:chaperone/firebase_options.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/services/auth_wrapper.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/admin_view.dart';
import 'package:chaperone/views/auth_views/forgot_password_view.dart';
import 'package:chaperone/views/auth_views/signup_view.dart';
import 'package:chaperone/views/compliance_views/contact_view.dart';
import 'package:chaperone/views/compliance_views/privacy_policy_view.dart';
import 'package:chaperone/views/compliance_views/terms_view.dart';
import 'package:chaperone/views/settings_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:chaperone/services/audio_manager.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Chaperone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          AppRoutes.appInitializer: (context) => const AppInitializer(),
          AppRoutes.signUp: (context) => SignUpView(
                authService: authService,
                isAnonymous: authService.isUserAnonymous(),
              ),
          AppRoutes.passwordRecovery: (context) => ForgotPasswordView(
                authService: authService,
              ),
          AppRoutes.contact: (context) => const ContactView(),
          AppRoutes.privacy: (context) => const PrivacyPolicyView(),
          AppRoutes.terms: (context) => const TermsView(),
          AppRoutes.settings: (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({super.key});

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer>
    with WidgetsBindingObserver {
  bool _hasUserConsent = !kIsWeb; // Automatically true for mobile platforms

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAudio();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final audioController = ref.read(audioControllerProvider.notifier);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        audioController.pauseThemeMusic();
      case AppLifecycleState.resumed:
        if (ref.read(audioControllerProvider).isThemeMusicEnabled &&
            _hasUserConsent) {
          audioController.playThemeMusic();
        }
    }
  }

  Future<void> _initializeAudio() async {
    await ref.read(audioControllerProvider.notifier).initAudio();
    if (!kIsWeb) {
      // For mobile platforms, play immediately
      await ref.read(audioControllerProvider.notifier).playThemeMusic();
    } else {
      // For web, show consent dialog
      _showConsentDialog();
    }
  }

  Future<void> _showConsentDialog() async {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome to Chaperone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'By playing Chaperone game, you agree to our Privacy Policy and Terms of Service.',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  TextButton(
                    child: const Text('Privacy Policy'),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.privacy);
                    },
                  ),
                  TextButton(
                    child: const Text('Terms of Service'),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.terms);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                setState(() => _hasUserConsent = false);
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Accept'),
              onPressed: () async {
                setState(() => _hasUserConsent = true);
                Navigator.of(context).pop();
                await ref
                    .read(audioControllerProvider.notifier)
                    .playThemeMusic();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AuthWrapper();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ref.read(audioControllerProvider.notifier).dispose();
    super.dispose();
  }
}
