class PublicData {
  final int aiFreeUsageLimit;
  final List<String> bannedEmails;
  final List<String> bannedIps;
  final List<String> bannedMacs;
  final String closedOthers;
  final String closedPersonal;
  final String generalRoom;
  final String zodiac;
  final String gptModel;
  final String geminiModel;

  PublicData({
    this.aiFreeUsageLimit = 0,
    this.bannedEmails = const [],
    this.bannedIps = const [],
    this.bannedMacs = const [],
    this.closedOthers = '',
    this.closedPersonal = '',
    this.generalRoom = '',
    this.zodiac = '',
    this.gptModel = '',
    this.geminiModel = '',
  });

  factory PublicData.fromMap(Map<String, dynamic>? data) {
    return PublicData(
      aiFreeUsageLimit: data?['aiFreeUsageLimit'] ?? 0,
      bannedEmails: List<String>.from(data?['bannedEmails'] ?? []),
      bannedIps: List<String>.from(data?['bannedIps'] ?? []),
      bannedMacs: List<String>.from(data?['bannedMacs'] ?? []),
      closedOthers: data?['closedOthers'] ?? '',
      closedPersonal: data?['closedPersonal'] ?? '',
      generalRoom: data?['generalRoom'] ?? '',
      zodiac: data?['zodiac'] ?? '',
      gptModel: data?['gptModel'] ?? '',
      geminiModel: data?['geminiModel'] ?? '',
    );
  }
}
