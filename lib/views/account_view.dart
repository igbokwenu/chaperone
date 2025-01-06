import 'package:chaperone/providers/user_data_provider.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/views/auth_views/signup_view.dart';
import 'package:chaperone/views/dynamic_stories_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountView extends ConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = AuthService();
    final currentUser = FirebaseAuth.instance.currentUser;
    final chaperoneUser =
        ref.watch(chaperoneUserDataProvider(currentUser?.uid)).value;
    return authService.isUserAnonymous()
        ? Center(
            child: Column(
              spacing: 20,
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
          )
        : Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text('Account'),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        // Email
                        Text(
                          chaperoneUser.email!,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Account Details Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Details',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                            Icons.person, 'Username', chaperoneUser.userName!),
                        _buildDetailRow(Icons.visibility, 'Display Name',
                            chaperoneUser.displayName!),
                        _buildDetailRow(Icons.location_on, 'Location',
                            chaperoneUser.country!),
                        // _buildDetailRow(Icons.calendar_today, 'Member Since',
                        //     chaperoneUser.timeStamp!.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

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
                    icon: const Icon(
                      Icons.book,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'View Stories You Created',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.blue.withOpacity(0.5),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
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
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      MyReusableFunctions.showCustomDialog(
                          context: context,
                          message:
                              'Are you sure you want to delete your account? This cannot be reversed!',
                          textColor: Colors.red,
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await authService.deleteUser();
                                await authService.signOut();

                                MyReusableFunctions.showCustomToast(
                                    description:
                                        "Account Deleted Successfully");
                              },
                              child: const Text(
                                'Delete Account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ]);
                    },
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[600],
            size: 24,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
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
}
