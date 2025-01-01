import 'dart:convert';

import 'package:chaperone/services/gemini_ai_service.dart';
import 'package:flutter/material.dart';

class TestGeminiScreen extends StatefulWidget {
  const TestGeminiScreen({Key? key}) : super(key: key);

  @override
  _TestGeminiScreenState createState() => _TestGeminiScreenState();
}

class _TestGeminiScreenState extends State<TestGeminiScreen> {
  final TextEditingController _promptController = TextEditingController();
  String _response = '';
  String _rawResponse = ''; // Added for debugging
  bool _isLoading = false;

  Future<void> _sendPrompt() async {
    setState(() {
      _isLoading = true;
      _response = '';
      _rawResponse = '';
    });

    try {
      final result = await GeminiService.sendTextPrompt(
        message: _promptController.text,
      );

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Creator UI Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter your prompt',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendPrompt,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Story'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_response),
                    ),
                    if (_rawResponse.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        _rawResponse,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
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
