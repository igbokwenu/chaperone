
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class to manage audio settings
class AudioState {
  final bool isThemeMusicEnabled;
  final bool isSoundEffectsEnabled;
  final bool isThemePlaying;

  AudioState({
    required this.isThemeMusicEnabled,
    required this.isSoundEffectsEnabled,
    required this.isThemePlaying,
  });

  AudioState copyWith({
    bool? isThemeMusicEnabled,
    bool? isSoundEffectsEnabled,
    bool? isThemePlaying,
  }) {
    return AudioState(
      isThemeMusicEnabled: isThemeMusicEnabled ?? this.isThemeMusicEnabled,
      isSoundEffectsEnabled: isSoundEffectsEnabled ?? this.isSoundEffectsEnabled,
      isThemePlaying: isThemePlaying ?? this.isThemePlaying,
    );
  }
}

class AudioController extends StateNotifier<AudioState> {
  AudioController()
      : super(AudioState(
          isThemeMusicEnabled: true,
          isSoundEffectsEnabled: true,
          isThemePlaying: false,
        ));

  final AudioPlayer _themePlayer = AudioPlayer();
  final AudioPlayer _resultPlayer = AudioPlayer();
  final AudioPlayer _soundEffectPlayer = AudioPlayer();

  Future<void> initAudio() async {
    await _themePlayer.setSource(AssetSource('audio/theme.mp3'));
    await _themePlayer.setReleaseMode(ReleaseMode.loop);
    await _resultPlayer.setSource(AssetSource('audio/result.mp3'));
    await _soundEffectPlayer.setSource(AssetSource('audio/answer.mp3'));
  }

  Future<void> toggleThemeMusic() async {
    state = state.copyWith(isThemeMusicEnabled: !state.isThemeMusicEnabled);
    if (!state.isThemeMusicEnabled) {
      await pauseThemeMusic();
    } else if (state.isThemePlaying) {
      await playThemeMusic();
    }
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

// Providers
final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>((ref) {
  return AudioController();
});