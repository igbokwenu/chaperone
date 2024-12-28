class StoryScenario {
  final String id;
  final String title;
  final String author;
  final String thumbnailUrl;
  final bool isVerified;
  final int views;
  final int likes;
  final int comments;
  final bool isBookmarked;
  final String? description;
  final String? questionOne;
  final String? questionOneImage;
  final String? answer1a;
  final String? answer1b;

  StoryScenario({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.isVerified,
    required this.views,
    required this.likes,
    required this.comments,
    this.isBookmarked = false,
    this.description,
    this.questionOne,
    this.questionOneImage,
    this.answer1a,
    this.answer1b,
  });
}

List<StoryScenario> mockScenarios = [
  StoryScenario(
    id: '1',
    title: 'The Job Interview',
    author: 'By Yuhang Han',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage9.png?alt=media&token=3325b642-0ccf-419f-b6f7-2453a3844359',
    isVerified: true,
    views: 32500,
    likes: 27800,
    comments: 6780,
    isBookmarked: false,
    description:
        'Enter the shoes of a determined woman who dares to shatter societal prejudices and workplace stereotypes. In this gripping narrative game, you face a grueling job interview where every question becomes a battlefield. Will you let their biases define you, or will you turn the tables with wit, resilience, and undeniable competence?',
    questionOne:
        'The hiring manager looks at you with a smile and asks: "So, are you married? Do you have plans to have children soon? How will you manage the demands of this job with family responsibilities?"',
    questionOneImage:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage1.png?alt=media&token=8e7ba19f-8446-4e20-ba85-212f44e2c481',
    answer1a:
        'You feel uncomfortable but decide to respond politely. "I\'d prefer to focus on my qualifications and how I can contribute to the company. My personal life should not impact my professional abilities."',
    answer1b:
        'You smile and say "I am married and have plans to have children."',
  ),
  StoryScenario(
    id: '2',
    title: 'Bloodlines of the Heart',
    author: 'By Jonathan Stiller',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage10.png?alt=media&token=73ff6db0-8a45-421f-8774-a73e3ac37749',
    isVerified: true,
    views: 28400,
    likes: 24300,
    comments: 5430,
    isBookmarked: true,
    description:
        "He is a vampire, but he is desperately in love with me. Can his love for me overcome his beastly thirst for blood? \nStep into a world where love defies the very laws of nature. You, a mortal with a heart full of life, find yourself irresistibly drawn to a centuries-old vampire whose very existence revolves around the essence of human blood. His love for you burns brighter than the eternal moonlight, but his monstrous instincts threaten to tear you apart.",
    questionOne:
        'You find yourself alone with him under the full moon. His crimson eyes glow faintly, filled with both love and torment. He says, \n"I can no longer deny it—I thirst for you, in every possible way. Tell me, do you trust me enough to resist my darkest instincts?"',
    questionOneImage:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage2.png?alt=media&token=4b8b52c0-34fe-40cb-b6fb-374c717d89c0',
    answer1a:
        'You take a deep breath and reply, "I trust you with all my heart. I believe love can conquer even the darkest shadows within you."',
    answer1b:
        'You hesitate, tears welling up in your eyes. "I want to trust you, but how can I be sure your love will always prevail over your thirst?"',
  ),
];
