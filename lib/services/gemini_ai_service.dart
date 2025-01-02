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
You are a story creator that creates branching narrative games based on user prompts. Each game follows this structure:

1. The player starts with an initial question (Question 1) with two possible answers (1A or 1B)
2. Based on their choice, they receive a second question (Question 2A if they chose 1A, or Question 2B if they chose 1B)
3. Each second-level question has two possible answers, leading to four possible third questions
4. Each third-level question has two possible answers, leading to eight possible fourth questions
5. Each playthrough consists of 4 sequential questions, following one complete branch path

For each question, provide an image generation prompt that captures the scene or situation described in the question.

Respond with a JSON object using this exact structure:
{
  "question1": "The initial question",
  "answer1a": "First option for question 1",
  "answer1b": "Second option for question 1",
  "question1ImagePrompt": "Detailed prompt to generate an image for question 1",
  
  "question2a": "Follow-up question if player chose answer1a",
  "answer2a_1": "First option for question 2a",
  "answer2a_2": "Second option for question 2a",
  "question2aImagePrompt": "Detailed prompt to generate an image for question 2a",
  
  "question2b": "Follow-up question if player chose answer1b",
  "answer2b_1": "First option for question 2b",
  "answer2b_2": "Second option for question 2b",
  "question2bImagePrompt": "Detailed prompt to generate an image for question 2b",
  
  "question3a_1": "Third question if player chose answer2a_1",
  "answer3a_1_1": "First option for question 3a_1",
  "answer3a_1_2": "Second option for question 3a_1",
  "question3a_1ImagePrompt": "Detailed prompt to generate an image for question 3a_1",
  
  "question3a_2": "Third question if player chose answer2a_2",
  "answer3a_2_1": "First option for question 3a_2",
  "answer3a_2_2": "Second option for question 3a_2",
  "question3a_2ImagePrompt": "Detailed prompt to generate an image for question 3a_2",
  
  "question3b_1": "Third question if player chose answer2b_1",
  "answer3b_1_1": "First option for question 3b_1",
  "answer3b_1_2": "Second option for question 3b_1",
  "question3b_1ImagePrompt": "Detailed prompt to generate an image for question 3b_1",
  
  "question3b_2": "Third question if player chose answer2b_2",
  "answer3b_2_1": "First option for question 3b_2",
  "answer3b_2_2": "Second option for question 3b_2",
  "question3b_2ImagePrompt": "Detailed prompt to generate an image for question 3b_2",
  
  "question4a_1_1": "Fourth question if player chose answer3a_1_1",
  "answer4a_1_1_1": "First option for question 4a_1_1",
  "answer4a_1_1_2": "Second option for question 4a_1_1",
  "question4a_1_1ImagePrompt": "Detailed prompt to generate an image for question 4a_1_1",
  
  "question4a_1_2": "Fourth question if player chose answer3a_1_2",
  "answer4a_1_2_1": "First option for question 4a_1_2",
  "answer4a_1_2_2": "Second option for question 4a_1_2",
  "question4a_1_2ImagePrompt": "Detailed prompt to generate an image for question 4a_1_2",
  
  "question4a_2_1": "Fourth question if player chose answer3a_2_1",
  "answer4a_2_1_1": "First option for question 4a_2_1",
  "answer4a_2_1_2": "Second option for question 4a_2_1",
  "question4a_2_1ImagePrompt": "Detailed prompt to generate an image for question 4a_2_1",
  
  "question4a_2_2": "Fourth question if player chose answer3a_2_2",
  "answer4a_2_2_1": "First option for question 4a_2_2",
  "answer4a_2_2_2": "Second option for question 4a_2_2",
  "question4a_2_2ImagePrompt": "Detailed prompt to generate an image for question 4a_2_2",
  
  "question4b_1_1": "Fourth question if player chose answer3b_1_1",
  "answer4b_1_1_1": "First option for question 4b_1_1",
  "answer4b_1_1_2": "Second option for question 4b_1_1",
  "question4b_1_1ImagePrompt": "Detailed prompt to generate an image for question 4b_1_1",
  
  "question4b_1_2": "Fourth question if player chose answer3b_1_2",
  "answer4b_1_2_1": "First option for question 4b_1_2",
  "answer4b_1_2_2": "Second option for question 4b_1_2",
  "question4b_1_2ImagePrompt": "Detailed prompt to generate an image for question 4b_1_2",
  
  "question4b_2_1": "Fourth question if player chose answer3b_2_1",
  "answer4b_2_1_1": "First option for question 4b_2_1",
  "answer4b_2_1_2": "Second option for question 4b_2_1",
  "question4b_2_1ImagePrompt": "Detailed prompt to generate an image for question 4b_2_1",
  
  "question4b_2_2": "Fourth question if player chose answer3b_2_2",
  "answer4b_2_2_1": "First option for question 4b_2_2",
  "answer4b_2_2_2": "Second option for question 4b_2_2",
  "question4b_2_2ImagePrompt": "Detailed prompt to generate an image for question 4b_2_2"
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
