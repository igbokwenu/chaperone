import 'package:chaperone/services/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// settings_screen.dart
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioControllerProvider);
    final audioController = ref.read(audioControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Theme Music Toggle
          SwitchListTile(
            title: const Text('Theme Music'),
            value: audioState.isThemeMusicEnabled,
            onChanged: (_) => audioController.toggleThemeMusic(),
          ),

          // Music Volume Slider (Theme & Result)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Music Volume'),
                Slider(
                  value: audioState.musicVolume,
                  onChanged: (value) => audioController.setMusicVolume(value),
                  min: 0.0,
                  max: 1.0,
                ),
              ],
            ),
          ),

          const Divider(),

          // Sound Effects Toggle
          SwitchListTile(
            title: const Text('Sound Effects'),
            value: audioState.isSoundEffectsEnabled,
            onChanged: (_) => audioController.toggleSoundEffects(),
          ),

          // Sound Effects Volume Slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sound Effects Volume'),
                Slider(
                  value: audioState.effectsVolume,
                  onChanged: (value) => audioController.setEffectsVolume(value),
                  min: 0.0,
                  max: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
