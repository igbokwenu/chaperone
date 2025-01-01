import 'package:chaperone/utils/constants/constants.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'dart:convert';

class GeminiService {
  static String _cleanJsonResponse(String response) {
    // Remove any markdown code block indicators
    response = response.replaceAll('```json', '').replaceAll('```', '');

    // Trim whitespace
    response = response.trim();

    return response;
  }

  static Future<Map<String, dynamic>?> sendTextPrompt({
    required String message,
    String? preferredModel,
  }) async {
    try {
      final model = FirebaseVertexAI.instance.generativeModel(
        model: preferredModel ?? 'gemini-1.5-flash',
      );

      final prompt = [
        Content.text('''
        You are a story creator that creates story based game using a prompt provided by a user. The story should have a total of 3 questions and 6 answers and a player will only answer 2 questions per playthrough. Each answer should have a relevant and related follow up question. Each question should have a prompt for image generation that can be used to generate an image that reflects the question asked.
       
        Respond with a JSON object containing the following fields without any markdown formatting or code blocks:
        {
          "question1": "string",
          "answer1a": "string",
          "answer1b": "string",
          "question1ImagePrompt": "string",
          "question21a": "string",
          "answer21a_1": "string",
          "answer21a_2": "string",
          "question21aImagePrompt": "string",
          "question21b": "string",
          "answer21b_1": "string",
          "answer21b_2": "string",
          "question21bImagePrompt": "string",
        }

        User message: $message
      ''')
      ];

      final response = await model.generateContent(prompt);

      if (response.text != null) {
        try {
          final cleanedResponse = _cleanJsonResponse(response.text!);
          print('Cleaned Response: $cleanedResponse'); // For debugging
          return jsonDecode(cleanedResponse);
        } catch (e) {
          print('Error parsing JSON response: $e');
          print('Raw response: ${response.text}'); // For debugging
          return null;
        }
      }
    } catch (e) {
      print('Error generating content: $e');
    }
    return null;
  }
}
