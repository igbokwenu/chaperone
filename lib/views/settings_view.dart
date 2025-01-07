import 'package:chaperone/services/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioControllerProvider);
    final audioController = ref.read(audioControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Theme Music'),
            value: audioState.isThemeMusicEnabled,
            onChanged: (_) => audioController.toggleThemeMusic(),
          ),
          SwitchListTile(
            title: Text('Sound Effects'),
            value: audioState.isSoundEffectsEnabled,
            onChanged: (_) => audioController.toggleSoundEffects(),
          ),
        ],
      ),
    );
  }
}