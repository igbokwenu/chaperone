//Gemini models documentation:https://ai.google.dev/models/gemini
const String geminiFlashModel = 'gemini-1.5-flash';
const String geminiProModel = 'gemini-1.5-pro';
const String gpt4OModel = "gpt-4o";
const String gpt4OMiniModel = "gpt-4o-mini";

class AppRoutes {
  static const String appInitializer = '/';
  static const String signUp = '/sign_up';
  static const String passwordRecovery = '/password_recovery';
  static const String contact = '/contact';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String account = '/account';
  static const String settings = '/settings';
}

const String logoAssetImageUrlCircular = "assets/images/logo_circular.png";
const String logoAssetImageUrlCircularWithTag =
    "assets/images/anecdotal_rounded_tag.png";
const String logoAssetImageUrlNoTagLine = "assets/images/logo_512x512.png";
const String logoAssetImageUrlOnlyLogo =
    "assets/images/anecdotal_only_logo.png";
const String logoAssetImageUrlWithTagLine =
    "assets/images/anecdotal_logo_tag_2000.png";

const logoAssetImageUrlSplash = 'assets/images/logo_splash.png';

//revenuecat keys
const googleApiKey = 'goog_vsEPEYPdkWRUGqBiNyaGMjSqHbt';
const appleApiKey = 'appl_kpeYPMlCLVQCfwiuRuBdPOfYaLL';
const amazonApiKey = '';
const entitlementID = 'pro';
const entitlementIdAndroid = 'android';

//User database reference:

const String userFirstName = 'firstName';
const String userLastName = 'lastName';
const String userCountry = 'country';
const String userState = 'state';
const String userEmail = 'email';
const String userIpCountry = 'ipCountry';
const String userIpState = 'ipState';
const String userProfilePicUrl = 'profilePicUrl';
const String userImageUrlForChat = 'imageUrl';
const String userIsAdmin = 'isAdmin';
const String userIsBanned = 'isBanned';
const String userIsSuperAdmin = 'isSuperAdmin';
const String userIsPro = 'isPro';
const String userUid = 'uid';
const String userAiMediaUsageCount = 'aiMediaUsageCount';
const String userAiTextUsageCount = 'aiTextUsageCount';
const String userAiGeneralMediaUsageCount = 'aiGeneralMediaUsageCount';
const String userAiGeneralTextUsageCount = 'aiGeneralTextUsageCount';
const String userDevice = 'device';
const String userTimeStamp = 'timeStamp';
const String usersMessagingToken = 'messagingToken';

const String userHighestScore = 'highestScore';
const String userUserName = 'userName';
const String userGameScores = 'gameScores';
const String userBookmarkedStoryUid = 'bookmarkedStoryUid';
const String userNoOfGamesCreated = 'noOfGamesCreated';
const String userMyGameIds = 'myGameIds';
const String userCreationTokens = 'creationTokens';
const String userAllowSoundEffects = 'allowSoundEffects';
const String userAllowGameMusic = 'allowGameMusic';
const String userFollowersList = 'followersList';
const String userFollowingList = 'followingList';
const String userDisplayName = 'displayName';
const String userStoryList = 'storyList';
const String userProgressList = 'progressList';
const String userProgressAnalysis = 'progressAnalysis';
const String userGameBeingBuilt = 'gameBeingBuilt';
const String userMusicVolumeLevel = 'musicVolumeLevel';
const String userSoundEffectVolumeLevel = 'soundEffectVolumeLevel';

//
const String storyUidKey = 'storyUid';
const String storyTitleKey = 'title';
const String storyAuthorKey = 'author';
const String storyThumbnailUrlKey = 'thumbnailUrl';
const String storyIsVerifiedKey = 'isVerified';
const String storyViewsKey = 'views';
const String storyLikesKey = 'likes';
const String storyCommentsKey = 'comments';
const String storyIsBookmarkedKey = 'isBookmarked';
const String storySynopsisKey = 'synopsis';
const String storyQuestion1Key = 'question1';
const String storyQuestionOneImageUrlKey = 'questionOneImageUrl';
const String storyAnswer1aKey = 'answer1a';
const String storyAnswer1bKey = 'answer1b';
const String storyLikeCountKey = 'likeCount';
const String storyCommentCountKey = 'commentCount';
const String storyPlayCountKey = 'playCount';
const String storyLikesUidKey = 'likesUid';
const String storyShareCountKey = 'shareCount';
const String storyIsPublishedKey = 'isPublished';
const String storyIsApprovedKey = 'isApproved';
const String storyIsRejectedKey = 'isRejected';
const String storyIsTrendingKey = 'isTrending';
const String storyIsBasedOnTrueStoryKey = 'isBasedOnTrueStory';
const String storyIsInspiredByTrueEventKey = 'isInspiredByTrueEvent';
const String storyIsForAdultKey = 'isForAdult';
const String storyGameUidKey = 'gameUid';
const String storyDescriptionKey = 'description';
const String storyAuthorNameKey = 'authorName';
const String storyAuthorUidKey = 'authorUid';
const String storyAuthorUsernameKey = 'authorUsername';
const String storyAuthorDisplayNameKey = 'authorDisplayname';
const String storyForMaleKey = 'forMale';
const String storyForFemaleKey = 'forFemale';
const String storyFollowersKey = 'followers';
const String storyBookmarksListKey = 'bookmarksList';
const String storyFavouritesListKey = 'favouritesList';
const String storyDataKey = 'storyData';
const String storyStoryCreationPromptKey = 'storyCreationPrompt';

const String createGamePitchText = """
Step into the exciting world of interactive storytelling! Create your own game about anything! Whether it's a story inspired by true events, an emotional journey from your life, a fantastical fiction, or a topic you're passionate about, the possibilities are endless!

Here, you are doing more than just creating a game—it's a chance to connect. Use your creation to spark meaningful conversations, process emotions in a creative way, or share a unique perspective with those you care about. Invite your friends and family to play, making your stories come alive in a fun, engaging way!  
""";

const String whyCreateGameText = """
Why create a game?  

- A Creative Outlet: Channel your ideas, emotions, and imagination into an interactive masterpiece.  
- Deeper Connections: Share your experiences and perspectives in a way that words alone can't express.  
- A Safe Space: Explore sensitive or difficult topics in a non-confrontational, immersive way.  
- Collaborative Fun: Invite others to explore your world and experience your story, turning every playthrough into a shared moment of joy, curiosity, or reflection.  
- Empowerment Through Storytelling: Shape the narrative, decide the outcomes, and make your voice heard.  

Whether you're looking to heal, entertain, or simply explore your creativity, Chaperone offers a unique and rewarding way to do it. Create, share, and game on—your story deserves to be told ❤️
""";

const String chaperoneLogoUrl512 =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png';

const String guyImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image10.png';
const String blackLadyImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image9.png';
const String whiteLadyImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image2.png';
const String dramaticImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image8.png';

const String gamePlaceholderBg =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/gifs/bg3.gif';

const String resultPageImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image7.png';
const String createGameImageUrl =
    'https://chaperonegame.s3.us-east-1.amazonaws.com/placeholder_images/image11.png';
const String str3 = '';
const String str4 = '';
const String str5 = '';
const String str6 = '';
const String str7 = '';
const String str8 = '';
const String str9 = '';
const String str10 = '';

class AppStrings {
  static const String privacyPolicyText = """
Welcome to Chaperone's Privacy Policy

Last Updated: January 6, 2025

At Chaperone, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our interactive storytelling platform.

1. Information We Collect
- Account Information: Username, email address, and password
- Story Content: Stories you create and interact with
- Usage Data: Interaction patterns, preferences, and gameplay statistics
- Device Information: Device type, operating system, and app version

2. How We Use Your Information
- To provide and maintain the storytelling platform
- To improve user experience and game features
- To communicate important updates and announcements
- To protect against misuse and ensure community safety

3. Data Storage and Security
- We implement industry-standard security measures
- Your story data is encrypted and securely stored
- We regularly backup data to prevent loss

4. User Rights
- You can access and export your data
- You have the right to delete your account and all associated data
- You can opt-out of non-essential communications

5. Data Deletion
You can permanently delete your account and all associated data through the Account Settings section. This process is irreversible and will remove:
- All account data
- Your profile information
- Interaction history and preferences

6. Children's Privacy
Chaperone is not intended for children under 13 years of age.

7. Contact Us
For privacy-related questions, please contact us through okechukwu@habilisfusion.co.
""";

  static const String termsOfServiceText = """
Chaperone Terms of Service

Last Updated: January 6, 2025

1. Acceptance of Terms
By accessing or using Chaperone, you agree to be bound by these Terms of Service.

2. User Content
- You retain ownership of your story creation prompts
- You grant us license to display and distribute your content
- You are responsible for the content you create
- Content must not violate our community guidelines

3. Prohibited Content
- Harmful or hateful content
- Copyright-infringing material
- Misleading information
- Content that violates others' privacy

4. Account Responsibilities
- Maintain accurate account information
- Keep login credentials secure
- Report unauthorized access
- One account per user

5. Service Modifications
We reserve the right to modify or discontinue services with reasonable notice.

6. Termination
We may terminate accounts that violate these terms or our community guidelines.

7. Liability Limitations
We provide the service "as is" without warranties of any kind.

8. Governing Law
These terms are governed by applicable laws.

9. Changes to Terms
We may update these terms with notice to users.
""";
}

const String kCurrentGame = 'currentGame';
const String kIsFavorite = 'isFavorite';
const String kByAuthor = 'byAuthor';
const String kStoriesDefaultEmptyMessage = 'No stories found';

List<String> storyPromptsExamples = [
  "I used to be bullied as a child, now I suffer with severe anxiety and self esteem issues. Create a game about how childhood bullying can ruin someones life.",
  "In a world where dreams are currencies, you’re hired to recover a lost memory hidden in a nightmare. Can you navigate surreal landscapes and uncover the truth, or will you keep the power for yourself?",
  "I invited all my friends and classmates to my birthday party and none of them came. Now I never want to celebrate my birthday ever again! I am devastated.",
  "You discover an old diary belonging to your estranged grandmother, filled with tales of her forbidden love during a time of war. As you follow her story, you uncover family secrets that could change your life forever.",
  "Every time you tell a lie, a scar appears on your skin. When a mysterious stranger offers to erase them for a price, you must decide whether to face your truth or pay the ultimate cost.",
  "Click here to enter your story prompt"
];

const List<String> adminsList = [
  'increasedwisdom@gmail.com',
  'yuhanghan97@gmail.com',
];
