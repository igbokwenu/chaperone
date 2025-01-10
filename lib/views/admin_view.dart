import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminView extends StatelessWidget {
  final StoryModel scenario;
  const AdminView({super.key, required this.scenario});

  final String paragraphText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  final String jsonText =
      '{\n  "name": "John Doe",\n  "age": 30,\n  "isAdmin": true,\n  "roles": ["user", "editor"]\n}';

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text Copied!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scenario.storyData![storyTitleKey]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Game ID',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        scenario.storyUid,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () =>
                          copyToClipboard(context, scenario.storyUid),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Location",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${scenario.authorState}, ${scenario.authorCountry}",
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => copyToClipboard(context,
                          "${scenario.authorState}, ${scenario.authorCountry}"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Game Prompt',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        scenario.storyCreationPrompt ?? 'Not available',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => copyToClipboard(context,
                          scenario.storyCreationPrompt ?? 'Not available'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Device',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        scenario.authorDevice ?? 'Not available',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => copyToClipboard(
                          context, scenario.authorDevice ?? 'Not available'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Game Data',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${scenario.storyData}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () =>
                          copyToClipboard(context, "${scenario.storyData}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
