import 'package:chaperone/utils/constants/constants.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

import 'dart:convert';

// class GeminiService {
//   static Future<Map<String, dynamic>?> sendTextPrompt({
//     required String message,
//     String? preferredModel,
//     required String apiKey,
//   }) async {
//     final model = GenerativeModel(
//       model: preferredModel ?? geminiFlashModel,
//       apiKey: apiKey,
//       generationConfig: GenerationConfig(
//         responseMimeType: "application/json",
//         responseSchema: Schema.object(
//           properties: {
//             "summary": Schema.string(),
//             "insights": Schema.array(items: Schema.string()),
//             "recommendations": Schema.array(items: Schema.string()),
//             "suggestions": Schema.array(items: Schema.string()),
//             "citations": Schema.array(items: Schema.string()),
//           },
//         ),
//       ),
//     );

//     final content = [Content.text(message)];
//     final response = await model.generateContent(content);

//     if (response.text != null) {
//       return jsonDecode(response.text!);
//     } else {
//       return null;
//     }
//   }}

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
        Respond with a JSON object containing the following fields without any markdown formatting or code blocks:
        {
          "summary": "string",
          "insights": ["string"],
          "recommendations": ["string"],
          "suggestions": ["string"],
          "citations": ["string"]
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
