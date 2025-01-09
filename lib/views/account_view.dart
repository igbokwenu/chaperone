import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chaperone/providers/user_data_provider.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/views/auth_views/signup_view.dart';
import 'package:chaperone/views/dynamic_stories_view.dart';
import 'package:chaperone/views/settings_view.dart';

class AccountView extends ConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = AuthService();
    final currentUser = FirebaseAuth.instance.currentUser;

    final asyncChaperoneUser =
        ref.watch(chaperoneUserDataProvider(currentUser?.uid));

    if (authService.isUserAnonymous()) {
      return Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your progress is not being saved. Sign in to save your progress and manage your stories.",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpView(
                      authService: authService,
                      isAnonymous: authService.isUserAnonymous(),
                    ),
                  ),
                );
              },
              child: const Text("Sign In To Save Your Progress"),
            ),
            ElevatedButton(
              onPressed: () async {
                await authService.deleteUser();
                await authService.signOut();
                MyReusableFunctions.showCustomToast(
                    description: "Signed out successfully");
              },
              child: const Text(
                "Sign Out & Delete Game Data",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    return asyncChaperoneUser.when(
      data: (chaperoneUser) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Account'),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // User Profile Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Profile Picture
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(chaperoneUser!.profilePicUrl!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Name
                    Text(
                      "${chaperoneUser.firstName} ${chaperoneUser.lastName}",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    // Email
                    Text(
                      chaperoneUser.email!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Account Details Section
              _buildAccountDetails(chaperoneUser),
              const SizedBox(height: 24),
              _buildActions(context, authService),
            ],
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text("Error: ${error.toString()}"),
      ),
    );
  }

  Widget _buildAccountDetails(chaperoneUser) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.person, 'Username', chaperoneUser.userName!),
          _buildDetailRow(
              Icons.visibility, 'Display Name', chaperoneUser.displayName!),
          _buildDetailRow(
              Icons.location_on, 'Location', chaperoneUser.country!),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, AuthService authService) {
    return Column(
      // spacing: 5,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const DynamicStoriesView(providerKey: kByAuthor),
              ),
            );
          },
          icon: const Icon(Icons.visibility, size: 24),
          label: const Text('View Stories You Created'),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            if (authService.isUserAnonymous()) {
              await authService.deleteUser();
              await authService.signOut();
              MyReusableFunctions.showCustomToast(
                  description: "Signed out successfully");
            } else {
              await authService.signOut();
            }
          },
          child: const Text('Sign Out'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async {
            MyReusableFunctions.showCustomDialog(
              context: context,
              message:
                  'Are you sure you want to delete your account? This cannot be reversed!',
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await authService.deleteUser();
                    await authService.signOut();
                    MyReusableFunctions.showCustomToast(
                        description: "Account Deleted Successfully");
                  },
                  child: const Text('Delete Account'),
                ),
              ],
            );
          },
          child: const Text(
            'Delete Account',
            style: TextStyle(color: Colors.red),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
