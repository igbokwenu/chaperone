// audio_manager.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioState {
  final bool isThemeMusicEnabled;
  final bool isSoundEffectsEnabled;
  final bool isThemePlaying;
  final double musicVolume;      // For theme and result music
  final double effectsVolume;    // For sound effects

  AudioState({
    required this.isThemeMusicEnabled,
    required this.isSoundEffectsEnabled,
    required this.isThemePlaying,
    required this.musicVolume,
    required this.effectsVolume,
  });

  AudioState copyWith({
    bool? isThemeMusicEnabled,
    bool? isSoundEffectsEnabled,
    bool? isThemePlaying,
    double? musicVolume,
    double? effectsVolume,
  }) {
    return AudioState(
      isThemeMusicEnabled: isThemeMusicEnabled ?? this.isThemeMusicEnabled,
      isSoundEffectsEnabled: isSoundEffectsEnabled ?? this.isSoundEffectsEnabled,
      isThemePlaying: isThemePlaying ?? this.isThemePlaying,
      musicVolume: musicVolume ?? this.musicVolume,
      effectsVolume: effectsVolume ?? this.effectsVolume,
    );
  }
}

class AudioController extends StateNotifier<AudioState> {
  AudioController()
      : super(AudioState(
          isThemeMusicEnabled: true,
          isSoundEffectsEnabled: true,
          isThemePlaying: false,
          musicVolume: 0.5,      // Default to 50% volume
          effectsVolume: 0.5,    // Default to 50% volume
        ));

  final AudioPlayer _themePlayer = AudioPlayer();
  final AudioPlayer _resultPlayer = AudioPlayer();
  final AudioPlayer _soundEffectPlayer = AudioPlayer();

  Future<void> initAudio() async {
    await _themePlayer.setSource(AssetSource('audio/theme.mp3'));
    await _resultPlayer.setSource(AssetSource('audio/result.mp3'));
    await _soundEffectPlayer.setSource(AssetSource('audio/answer.mp3'));
    
    await _themePlayer.setReleaseMode(ReleaseMode.loop);
    
    // Set initial volumes
    await _updateMusicVolume(state.musicVolume);
    await _updateEffectsVolume(state.effectsVolume);
  }

  Future<void> toggleThemeMusic() async {
    final newEnabledState = !state.isThemeMusicEnabled;
    state = state.copyWith(isThemeMusicEnabled: newEnabledState);
    
    if (!newEnabledState) {
      await pauseThemeMusic();
    } else {
      await playThemeMusic();
    }
  }

  Future<void> setMusicVolume(double volume) async {
    state = state.copyWith(musicVolume: volume);
    await _updateMusicVolume(volume);
  }

  Future<void> setEffectsVolume(double volume) async {
    state = state.copyWith(effectsVolume: volume);
    await _updateEffectsVolume(volume);
  }

  Future<void> _updateMusicVolume(double volume) async {
    await _themePlayer.setVolume(volume);
    await _resultPlayer.setVolume(volume);
  }

  Future<void> _updateEffectsVolume(double volume) async {
    await _soundEffectPlayer.setVolume(volume);
  }

  Future<void> toggleSoundEffects() async {
    state = state.copyWith(isSoundEffectsEnabled: !state.isSoundEffectsEnabled);
  }

  Future<void> playThemeMusic() async {
    if (state.isThemeMusicEnabled) {
      await _themePlayer.resume();
      state = state.copyWith(isThemePlaying: true);
    }
  }

  Future<void> pauseThemeMusic() async {
    await _themePlayer.pause();
    state = state.copyWith(isThemePlaying: false);
  }

  Future<void> playResultMusic() async {
    await pauseThemeMusic();
    if (state.isThemeMusicEnabled) {
      await _resultPlayer.resume();
    }
  }

  Future<void> stopResultMusic() async {
    await _resultPlayer.stop();
    if (state.isThemeMusicEnabled) {
      await playThemeMusic();
    }
  }

  Future<void> playSoundEffect() async {
    if (state.isSoundEffectsEnabled) {
      await _soundEffectPlayer.resume();
    }
  }

  void dispose() {
    _themePlayer.dispose();
    _resultPlayer.dispose();
    _soundEffectPlayer.dispose();
  }
}

final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>((ref) {
  return AudioController();
});