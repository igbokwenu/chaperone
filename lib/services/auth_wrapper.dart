import 'package:chaperone/providers/auth_provider.dart';
import 'package:chaperone/views/home_view.dart';
import 'package:chaperone/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeView(); // User is signed in
        } else {
          return const OnboardingView(); // User is NOT signed in
        }
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
