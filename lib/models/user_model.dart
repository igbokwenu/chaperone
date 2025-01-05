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
  final List<String> storyList;
  final bool isAdmin;
  final bool isBanned;
  final bool isSuperAdmin;
  final bool isPro;
  final int aiMediaUsageCount;
  final int aiTextUsageCount;
  final int aiGeneralMediaUsageCount;
  final int aiGeneralTextUsageCount;
  final int? highestScore;
  final String? userName;
  final List<int> gameScores;
  final String? bookmarkedStoryUid;
  final int noOfGamesCreated;
  final List<String> myGameIds;
  final int creationTokens;
  final bool allowSoundEffects;
  final bool allowGameMusic;
  final List<String>? followersList;
  final List<String>? followingList;
  final String? displayName;
  final String? gameBeingBuilt;

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
    this.storyList = const [],
    this.isAdmin = false,
    this.isBanned = false,
    this.isSuperAdmin = false,
    this.isPro = false,
    this.aiMediaUsageCount = 0,
    this.aiTextUsageCount = 0,
    this.aiGeneralMediaUsageCount = 0,
    this.aiGeneralTextUsageCount = 0,
    this.highestScore,
    this.userName,
    this.gameScores = const [],
    this.bookmarkedStoryUid,
    this.noOfGamesCreated = 0,
    this.myGameIds = const [],
    this.creationTokens = 0,
    this.allowSoundEffects = true,
    this.allowGameMusic = true,
    this.followersList,
    this.followingList,
    this.displayName,
    this.gameBeingBuilt,
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
      progressAnalysis: data?[userProgressAnalysis],
      progressList: List<String>.from(data?[userProgressList] ?? []),
      storyList: List<String>.from(data?[userStoryList] ?? []),
      isAdmin: data?[userIsAdmin] ?? false,
      isBanned: data?[userIsBanned] ?? false,
      isSuperAdmin: data?[userIsSuperAdmin] ?? false,
      isPro: data?[userIsPro] ?? false,
      aiMediaUsageCount: data?[userAiMediaUsageCount] ?? 0,
      aiTextUsageCount: data?[userAiTextUsageCount] ?? 0,
      aiGeneralMediaUsageCount: data?[userAiGeneralMediaUsageCount] ?? 0,
      aiGeneralTextUsageCount: data?[userAiGeneralTextUsageCount] ?? 0,
      highestScore: data?[userHighestScore],
      userName: data?[userUserName],
      gameScores: List<int>.from(data?[userGameScores] ?? []),
      bookmarkedStoryUid: data?[userBookmarkedStoryUid],
      noOfGamesCreated: data?[userNoOfGamesCreated] ?? 0,
      myGameIds: List<String>.from(data?[userMyGameIds] ?? []),
      creationTokens: data?[userCreationTokens] ?? 0,
      allowSoundEffects: data?[userAllowSoundEffects] ?? true,
      allowGameMusic: data?[userAllowGameMusic] ?? true,
      followersList: data?[userFollowersList] != null
          ? List<String>.from(data?[userFollowersList])
          : null,
      followingList: data?[userFollowingList] != null
          ? List<String>.from(data?[userFollowingList])
          : null,
      displayName: data?[userDisplayName],
      gameBeingBuilt: data?[userGameBeingBuilt],
    );
  }
}
