//Gemini models documentation:https://ai.google.dev/models/gemini
const String geminiFlashModel = 'gemini-1.5-flash';
const String geminiProModel = 'gemini-1.5-pro';
const String gpt4OModel = "gpt-4o";
const String gpt4OMiniModel = "gpt-4o-mini";

class AppRoutes {
  static const String authWrapper = '/authWrapper';
  static const String signUp = '/sign_up';
  static const String passwordRecovery = '/password_recovery';
  // static const String home = '/home';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String account = '/account';
  static const String download = '/download';
  static const String onboardingWrapper = '/';
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

const String placeholderImageUrl = 'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f';

const String createGamePitchText = """
Step into the exciting world of interactive storytelling! Create your own game about anything! Whether it's a story inspired by true events, an emotional journey from your life, a fantastical fiction, or a topic you're passionate about, the possibilities are endless!

Here, you are doing more than just creating a game—it's a chance to connect. Use your creation to spark meaningful conversations, process emotions in a creative way, or share a unique perspective with those you care about. Invite your friends and family to play, making your stories come alive in a fun, engaging way!  

Why create a game?  
- A Creative Outlet: Channel your ideas, emotions, and imagination into an interactive masterpiece.  
- Deeper Connections: Share your experiences and perspectives in a way that words alone can't express.  
- A Safe Space: Explore sensitive or difficult topics in a non-confrontational, immersive way.  
- Collaborative Fun: Invite others to explore your world and experience your story, turning every playthrough into a shared moment of joy, curiosity, or reflection.  
- Empowerment Through Storytelling: Shape the narrative, decide the outcomes, and make your voice heard.  

Whether you're looking to heal, entertain, or simply explore your creativity, Chaperone offers a unique and rewarding way to do it. Create, share, and game on—your story deserves to be told ❤️
""";
