import 'dart:convert';

import 'package:chaperone/providers/user_data_provider.dart';
import 'package:chaperone/services/auth_wrapper.dart';
import 'package:chaperone/services/database_service.dart';
import 'package:chaperone/services/gemini_ai_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/views/dynamic_stories_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGameView extends ConsumerStatefulWidget {
  const CreateGameView({super.key});

  @override
  ConsumerState<CreateGameView> createState() => CreateGameViewState();
}

class CreateGameViewState extends ConsumerState<CreateGameView> {
  final TextEditingController _promptController = TextEditingController();

  String _response = '';
  String _rawResponse = '';
  bool _isLoading = false;
  int minCharacter = 20;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final chapeoneUser =
        ref.watch(chaperoneUserDataProvider(currentUser?.uid)).value;
    Future<void> sendPrompt() async {
      if (_promptController.text.isEmpty ||
          _promptController.text.length < minCharacter) {
        MyReusableFunctions.showCustomToast(
            description:
                'Please enter at least $minCharacter characters for your story prompt');
        return;
      }

      final firebaseUser = FirebaseAuth.instance.currentUser;
      final databaseService = DatabaseService(uid: firebaseUser?.uid ?? '');
      setState(() {
        _isLoading = true;
        _response = '';
        _rawResponse = '';
      });

      try {
        final result = await GeminiService.sendTextPrompt(
          message: _promptController.text,
        );

        if (result != null) {}

        await databaseService.createStoryDocument(storyData: result);
        ref.invalidate(chaperoneUserDataProvider(firebaseUser?.uid));
        setState(() {
          _response = result != null
              ? const JsonEncoder.withIndent('  ').convert(result)
              : 'No response received';
          _rawResponse = 'Raw response available in debug console';
        });
      } catch (e) {
        setState(() {
          _response = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;

          // Add navigation after setting loading state to false
          setState(() {
            _isLoading = false;

            MyReusableFunctions.showCustomDialog(
                barrierDismissible:
                    currentUser?.email == 'increasedwisdom@gmail.com' ||
                            currentUser?.email == 'yuhanghan97@gmail.com'
                        ? true
                        : false,
                context: context,
                message:
                    'Your game has been created successfully. Click the button below to preview the game and generate game images.',
                actions: [
                  TextButton(
                      onPressed: () async {
                        final chaperoneUser = ref
                            .read(chaperoneUserDataProvider(firebaseUser?.uid))
                            .value;
                        final databaseServiceForStoryPromptUpdate =
                            DatabaseService(
                                uid: chaperoneUser!.gameBeingBuilt ?? '');
                        if (kDebugMode) {
                          print(
                              "Uid of game being built: ${chaperoneUser.gameBeingBuilt}");
                        }
                        await databaseServiceForStoryPromptUpdate
                            .updateAnyStoriesData(
                                fieldName: storyStoryCreationPromptKey,
                                newValue: _promptController.text);
                        Navigator.of(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DynamicStoriesView(
                                    providerKey: kCurrentGame,
                                    storyUid: chaperoneUser!.gameBeingBuilt!,
                                  )),
                        );
                      },
                      child: const Text("Preview Game"))
                ]);
          });
        });
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Story Creator Beta'),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _promptController,
                      decoration: InputDecoration(
                        labelText:
                            'Enter your story prompt (min $minCharacter characters)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      maxLines: 3,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : sendPrompt,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Create Game',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: 24),
                // if (kDebugMode)
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Generated Story (Raw Template)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SelectableText(
                              _response,
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
                          ),
                          if (_rawResponse.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              _rawResponse,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }
}
