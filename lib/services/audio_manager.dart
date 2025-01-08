// audio_manager.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioState {
  final bool isThemeMusicEnabled;
  final bool isSoundEffectsEnabled;
  final bool isThemePlaying;
  final double musicVolume;
  final double effectsVolume;

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
      isSoundEffectsEnabled:
          isSoundEffectsEnabled ?? this.isSoundEffectsEnabled,
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
          musicVolume: 0.5,
          effectsVolume: 0.5,
        ));

  final AudioPlayer _themePlayer = AudioPlayer();
  final AudioPlayer _resultPlayer = AudioPlayer();
  final AudioPlayer _soundEffectPlayer = AudioPlayer();
  bool _isInitialized = false;

  Future<void> initAudio() async {
    if (_isInitialized) return;

    await _themePlayer.setSource(AssetSource('audio/theme.mp3'));
    await _resultPlayer.setSource(AssetSource('audio/result.mp3'));
    await _soundEffectPlayer.setSource(AssetSource('audio/answer.mp3'));

    await _themePlayer.setReleaseMode(ReleaseMode.loop);

    await _updateMusicVolume(state.musicVolume);
    await _updateEffectsVolume(state.effectsVolume);

    _isInitialized = true;
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

  Future<void> toggleSoundEffects() async {
    state = state.copyWith(isSoundEffectsEnabled: !state.isSoundEffectsEnabled);
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

  Future<void> playThemeMusic() async {
    if (!state.isThemeMusicEnabled || state.isThemePlaying) return;

    try {
      final playerState = _themePlayer.state;
      if (playerState == PlayerState.playing) return;

      await _themePlayer.resume();
      state = state.copyWith(isThemePlaying: true);
    } catch (e) {
      print('Error playing theme music: $e');
    }
  }

  Future<void> pauseThemeMusic() async {
    if (!state.isThemePlaying) return;

    try {
      await _themePlayer.pause();
      state = state.copyWith(isThemePlaying: false);
    } catch (e) {
      print('Error pausing theme music: $e');
    }
  }

  Future<void> playResultMusic() async {
    await pauseThemeMusic();
    if (state.isThemeMusicEnabled) {
      try {
        await _resultPlayer.resume();
      } catch (e) {
        print('Error playing result music: $e');
      }
    }
  }

  Future<void> stopResultMusic() async {
    try {
      await _resultPlayer.stop();
      if (state.isThemeMusicEnabled) {
        await playThemeMusic();
      }
    } catch (e) {
      print('Error stopping result music: $e');
    }
  }

  Future<void> playSoundEffect() async {
    if (state.isSoundEffectsEnabled) {
      try {
        await _soundEffectPlayer.seek(Duration.zero); // Reset to start
        await _soundEffectPlayer.resume();
      } catch (e) {
        print('Error playing sound effect: $e');
      }
    }
  }

  @override
  void dispose() {
    _themePlayer.dispose();
    _resultPlayer.dispose();
    _soundEffectPlayer.dispose();
    _isInitialized = false;
  }
}

final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>((ref) {
  return AudioController();
});
