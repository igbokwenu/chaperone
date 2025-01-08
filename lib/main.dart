// main.dart
import 'package:chaperone/firebase_options.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/services/auth_wrapper.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/views/auth_views/forgot_password_view.dart';
import 'package:chaperone/views/auth_views/signup_view.dart';
import 'package:chaperone/views/compliance_views/contact_view.dart';
import 'package:chaperone/views/compliance_views/privacy_policy_view.dart';
import 'package:chaperone/views/compliance_views/terms_view.dart';
import 'package:firebase_core/firebase_core.dart';
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
        // App is in background, hidden, or being closed
        audioController.pauseThemeMusic();
      case AppLifecycleState.resumed:
        // App is in foreground
        if (ref.read(audioControllerProvider).isThemeMusicEnabled) {
          audioController.playThemeMusic();
        }
    }
  }

  Future<void> _initializeAudio() async {
    await ref.read(audioControllerProvider.notifier).initAudio();
    await ref.read(audioControllerProvider.notifier).playThemeMusic();
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
