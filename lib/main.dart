// main.dart
import 'package:chaperone/firebase_options.dart';
import 'package:chaperone/services/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:chaperone/services/audio_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Chaperone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppInitializer(),
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
