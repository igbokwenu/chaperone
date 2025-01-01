import 'package:chaperone/utils/constants/constants.dart';

class ChaperoneUserData {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? country;
  final String? state;
  final String? email;
  final String? profilePicUrl;
  final String? progressAnalysis;
  final List<String> progressList;
  final List<String> userStoryList;
  final bool isAdmin;
  final bool isBanned;
  final bool isSuperAdmin;
  final bool isPro;
  final int aiMediaUsageCount;
  final int aiTextUsageCount;
  final int aiGeneralMediaUsageCount;
  final int aiGeneralTextUsageCount;

  ChaperoneUserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.country,
    this.state,
    this.email,
    this.profilePicUrl,
    this.progressAnalysis,
    this.progressList = const [],
    this.userStoryList = const [],
    this.isAdmin = false,
    this.isBanned = false,
    this.isSuperAdmin = false,
    this.isPro = false,
    this.aiMediaUsageCount = 0,
    this.aiTextUsageCount = 0,
    this.aiGeneralMediaUsageCount = 0,
    this.aiGeneralTextUsageCount = 0,
  });

  factory ChaperoneUserData.fromMap(Map<String, dynamic>? data) {
    return ChaperoneUserData(
      uid: data?[userUid],
      firstName: data?[userFirstName],
      lastName: data?[userLastName],
      country: data?[userCountry],
      state: data?[userState],
      email: data?[userEmail],
      profilePicUrl: data?[userProfilePicUrl],
      isAdmin: data?[userIsAdmin] ?? false,
      isBanned: data?[userIsBanned] ?? false,
      isSuperAdmin: data?[userIsSuperAdmin] ?? false,
      isPro: data?[userIsPro] ?? false,
  
      aiMediaUsageCount: data?[userAiMediaUsageCount] ?? 0,
      aiTextUsageCount: data?[userAiTextUsageCount] ?? 0,
      aiGeneralMediaUsageCount: data?[userAiGeneralMediaUsageCount] ?? 0,
      aiGeneralTextUsageCount: data?[userAiGeneralTextUsageCount] ?? 0,

    );
  }
}
