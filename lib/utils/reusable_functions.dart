import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class MyReusableFunctions {
  static bool dateChecker({DateTime? targetDate}) {
    // Default date (October 15, 2024)
    //Modify targetDate like so: targetDate: DateTime(2024, 10, 01)
    final DateTime defaultTargetDate = DateTime(2024, 10, 15);
    final currentDate = DateTime.now();

    final DateTime checkDate = targetDate ?? defaultTargetDate;

    // Compare the current date and target date (ignoring time)
    return currentDate.year == checkDate.year &&
        currentDate.month == checkDate.month &&
        currentDate.day == checkDate.day;
  }

  static Future<void> launchMail({String? address}) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri url = Uri(
      scheme: 'mailto',
      path: address ?? "okechukwu@habilisfusion.co",
      query: encodeQueryParameters(<String, String>{
        'subject': uid == null
            ? 'Enquiries About Anecdotal'
            : '❤️From Anecdotal App❤️',
        'body': uid == null
            ? ''
            : 'Anecdotal User ID: ${FirebaseAuth.instance.currentUser?.uid} \n\n <--- Add Message Below This Text ---> \n\n',
      }),
    );
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchGoogleSearch(String searchQuery) async {
    final String url =
        'https://www.google.com/search?q=$searchQuery'; // replace with your desired search engine
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      // use inAppWebView to open within the app
      throw Exception('Could not launch search');
    }
  }

  static Future<void> launchCustomUrl(
      {required String url, LaunchMode? launchMode}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri,
        mode: launchMode ?? LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Static method to show custom toast
  static void showCustomToast({
    required String description, // Required parameter
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    String title = "Notice",
    Alignment alignment = Alignment.topCenter,
    Duration duration = const Duration(seconds: 8),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    bool applyBlurEffect = false,
    List<BoxShadow>? boxShadow,
  }) {
    toastification.show(
      type: type,
      style: style,
      title: Text(title),
      description: Text(description),
      alignment: alignment,
      autoCloseDuration: duration,
      borderRadius: borderRadius,
      boxShadow: boxShadow ?? lowModeShadow,
      applyBlurEffect: applyBlurEffect,
    );
  }

  static void showProcessingToast({
    String description = '', // Required parameter
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    String title = "Processing... please wait",
    Alignment alignment = Alignment.topCenter,
    Duration duration = const Duration(seconds: 4),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    bool applyBlurEffect = false,
    List<BoxShadow>? boxShadow,
  }) {
    toastification.show(
      type: type,
      style: style,
      title: Text(title),
      // description: Text(description),
      alignment: alignment,
      autoCloseDuration: duration,
      borderRadius: borderRadius,
      boxShadow: boxShadow ?? lowModeShadow,
      applyBlurEffect: applyBlurEffect,
    );
  }

  static Future<void> showCustomDialog({
    required BuildContext context,
    Widget? widget,
    IconData? icon,
    Color? dialogIconColor,
    List<Widget>? actions,
    required String message,
    String? actionButtonText,
    Color? textColor,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(
          icon ?? Icons.info,
          size: 40,
          color: dialogIconColor ?? Theme.of(context).iconTheme.color,
        ),
        content: widget ??
            SingleChildScrollView(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16, // Adjust the font size as needed
                  color:
                      textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        actions: actions ??
            <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  actionButtonText ?? 'Close',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as needed
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
      ),
    );
  }

static String generateRandomUsername() {
    // List of name prefixes
    final List<String> namePrefixes = [
      "Shadow",
      "Mystery",
      "Wanderer",
      "Specter",
      "Phantom",
      "Echo",
      "Nomad",
      "Ghost",
      "Cipher",
      "Drifter",
      "Nebula",
      "Whisper",
      "Rogue",
      "Unknown",
      "Enigma",
      "Veil",
      "Chimera",
      "Orbit",
      "Silent",
      "Anon",
      "Guest",
      "Mysterious",
      "Incog",
      "Whispr",
      "Lurker",
      "Mystic"
    ];

    // Create a random number generator
    final Random random = Random();

    // Get a random name prefix from the list
    String randomPrefix = namePrefixes[random.nextInt(namePrefixes.length)];

    // Generate a random 5-digit number
    String randomNumber = (random.nextInt(90000) + 10000).toString();

    // Combine the prefix with the random number
    return '$randomPrefix-$randomNumber';
  }
}
