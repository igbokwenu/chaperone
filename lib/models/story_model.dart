class StoryModel {
  final String storyUid;
  final String title;
  final String author;
  final String thumbnailUrl;
  final bool isVerified;
  final int views;
  final int likes;
  final int comments;
  final bool isBookmarked;
  final String? synopsis;
  final String? question1;
  final String? questionOneImageUrl;
  final String? answer1a;
  final String? answer1b;
  final int? likeCount;
  final int? commentCount;
  final int? playCount;
  final List<String>? likesUid;
  final int? shareCount;
  final bool? isPublished;
  final bool? isApproved;
  final bool? isRejected;
  final bool? isTrending;
  final bool? isBasedOnTrueStory;
  final bool? isInspiredByTrueEvent;
  final bool? isForAdult;
  final String? gameUid;
  final String? description;
  final String? authorName;
  final String? authorUid;
  final bool? forMale;
  final bool? forFemale;
  final List<String>? followers;
  final Map<String, dynamic>? storyData;

  StoryModel(
      {required this.storyUid,
      required this.title,
      required this.author,
      required this.thumbnailUrl,
      required this.isVerified,
      required this.views,
      required this.likes,
      required this.comments,
      this.isBookmarked = false,
      this.synopsis,
      this.question1,
      this.questionOneImageUrl,
      this.answer1a,
      this.answer1b,
      this.likeCount,
      this.commentCount,
      this.playCount,
      this.likesUid,
      this.shareCount,
      this.isPublished,
      this.isApproved,
      this.isRejected,
      this.isTrending,
      this.isBasedOnTrueStory,
      this.isInspiredByTrueEvent,
      this.isForAdult,
      this.gameUid,
      this.description,
      this.authorName,
      this.authorUid,
      this.forMale,
      this.forFemale,
      this.followers,
      this.storyData});
}

List<StoryModel> mockScenarios = [
  StoryModel(
    storyUid: '1',
    title: 'The Job Interview',
    author: 'Yuhang Han',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage9.png?alt=media&token=3325b642-0ccf-419f-b6f7-2453a3844359',
    isVerified: true,
    views: 32500,
    likes: 27800,
    comments: 6780,
    isBookmarked: false,
    synopsis:
        'Enter the shoes of a determined woman who dares to shatter societal prejudices and workplace stereotypes. In this gripping narrative game, you face a grueling job interview where every question becomes a battlefield. Will you let their biases define you, or will you turn the tables with wit, resilience, and undeniable competence?',
    question1:
        'The hiring manager looks at you with a smile and asks: "So, are you married? Do you have plans to have children soon? How will you manage the demands of this job with family responsibilities?"',
    questionOneImageUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage1.png?alt=media&token=8e7ba19f-8446-4e20-ba85-212f44e2c481',
    answer1a:
        'You feel uncomfortable but decide to respond politely. "I\'d prefer to focus on my qualifications and how I can contribute to the company. My personal life should not impact my professional abilities."',
    answer1b:
        'You smile and say "I am married and have plans to have children."',
  ),
  StoryModel(
    storyUid: '2',
    title: 'Bloodlines of the Heart',
    author: 'Jonathan Stiller',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage10.png?alt=media&token=73ff6db0-8a45-421f-8774-a73e3ac37749',
    isVerified: true,
    views: 28400,
    likes: 24300,
    comments: 5430,
    isBookmarked: true,
    synopsis:
        "He is a vampire, but he is desperately in love with me. Can his love for me overcome his beastly thirst for blood? \nStep into a world where love defies the very laws of nature. You, a mortal with a heart full of life, find yourself irresistibly drawn to a centuries-old vampire whose very existence revolves around the essence of human blood. His love for you burns brighter than the eternal moonlight, but his monstrous instincts threaten to tear you apart.",
    question1:
        'You find yourself alone with him under the full moon. His crimson eyes glow faintly, filled with both love and torment. He says, \n"I can no longer deny it—I thirst for you, in every possible way. Tell me, do you trust me enough to resist my darkest instincts?"',
    questionOneImageUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage2.png?alt=media&token=4b8b52c0-34fe-40cb-b6fb-374c717d89c0',
    answer1a:
        'You take a deep breath and reply, "I trust you with all my heart. I believe love can conquer even the darkest shadows within you."',
    answer1b:
        'You hesitate, tears welling up in your eyes. "I want to trust you, but how can I be sure your love will always prevail over your thirst?"',
  ),
  StoryModel(
    storyUid: '3',
    title: 'Mirror, Mirror, On The Wall...',
    author: 'Story Author',
    thumbnailUrl: 'https://placeholder.com/story-thumbnail',
    isVerified: true,
    views: 15000,
    likes: 8500,
    comments: 1200,
    isBookmarked: false,
    synopsis:
        'A journey of self-discovery and acceptance as you confront your own reflection and grapple with societal beauty standards.',
    storyData: mirrorStoryBranches,
  ),
  StoryModel(
    storyUid: '4',
    title: 'Bloodlines of the Heart',
    author: 'Jonathan Stiller',
    thumbnailUrl:
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage10.png?alt=media&token=73ff6db0-8a45-421f-8774-a73e3ac37749',
    isVerified: true,
    views: 28400,
    likes: 24300,
    comments: 5430,
    isBookmarked: true,
    synopsis:
        "He is a vampire, but he is desperately in love with me. Can his love for me overcome his beastly thirst for blood? \nStep into a world where love defies the very laws of nature. You, a mortal with a heart full of life, find yourself irresistibly drawn to a centuries-old vampire whose very existence revolves around the essence of human blood. His love for you burns brighter than the eternal moonlight, but his monstrous instincts threaten to tear you apart.",
    storyData: vampireStoryBranches,
  ),
];

final Map<String, dynamic> mirrorStoryBranches = {
  'start': {
    'question':
        'You stand before a mirror, staring at your reflection. Do you see beauty or flaws?',
    'imagePrompt':
        'A person staring at their reflection in a mirror, with a neutral expression. The mirror is old and ornate, with a chipped frame.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text': 'I see beauty. I embrace my unique features.',
        'nextNode': 'question2a'
      },
      'b': {
        'text': 'I see flaws. I feel insecure and inadequate.',
        'nextNode': 'question2b'
      }
    }
  },
  'question2a': {
    'question':
        'You smile at your reflection, feeling confident. What do you do next?',
    'imagePrompt':
        'A person standing in front of a mirror, smiling confidently. The background is a sunny cityscape.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text': 'I walk out into the world, ready to conquer the day.',
        'nextNode': 'question3a_1'
      },
      'b': {
        'text':
            'I take a selfie to share with my friends, showcasing my confidence.',
        'nextNode': 'question3a_2'
      }
    }
  },
  'question2b': {
    'question':
        'You turn away from the mirror, feeling disheartened. What do you do next?',
    'imagePrompt':
        'A person looking away from a mirror, with a sad expression. The room is dimly lit, with shadows cast on the wall.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'I try to change my appearance to fit in with societal beauty standards.',
        'nextNode': 'question3b_1'
      },
      'b': {
        'text': 'I seek validation from others, hoping they will reassure me.',
        'nextNode': 'question3b_2'
      }
    }
  },
  'question3a_1': {
    'question':
        'You confidently stride through the streets, feeling empowered. What happens next?',
    'imagePrompt':
        'A person walking down a crowded city street, with a confident smile. The sun is shining brightly and people are going about their day.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text': 'You encounter a stranger who compliments your unique style.',
        'nextNode': 'question4a_1_1'
      },
      'b': {
        'text':
            'You notice people staring at you, but you hold your head high.',
        'nextNode': 'question4a_1_2'
      }
    }
  },
  'question3a_2': {
    'question':
        'You post your selfie online, hoping for positive feedback. What happens next?',
    'imagePrompt':
        'A person looking at their phone, scrolling through comments on a social media post, with a hopeful expression. The phone screen is glowing brightly in the dark room.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You receive an overwhelming amount of positive comments and likes.',
        'nextNode': 'question4a_2_1'
      },
      'b': {
        'text':
            'You encounter negative comments and trolls who attack your appearance.',
        'nextNode': 'question4a_2_2'
      }
    }
  },
  'question3b_1': {
    'question':
        'You spend hours trying to change your appearance, but feel unsatisfied. What happens next?',
    'imagePrompt':
        'A person surrounded by makeup and beauty products, looking frustrated and overwhelmed. The room is cluttered and messy, with a dim light.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You realize that true beauty comes from within, not from conforming to societal norms.',
        'nextNode': 'question4b_1_1'
      },
      'b': {
        'text':
            'You become obsessed with trying to achieve the \'perfect\' look, neglecting your mental health.',
        'nextNode': 'question4b_1_2'
      }
    }
  },
  'question3b_2': {
    'question':
        'You seek validation from friends and family, but their responses don\'t satisfy you. What happens next?',
    'imagePrompt':
        'A person sitting alone in a room, surrounded by empty chairs, looking lost and sad. The room is dimly lit, with a single lamp casting a warm glow.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You realize that you need to find acceptance within yourself, not from others.',
        'nextNode': 'question4b_2_1'
      },
      'b': {
        'text':
            'You become increasingly withdrawn and isolated, feeling like you don\'t belong.',
        'nextNode': 'question4b_2_2'
      }
    }
  },
  'question4a_1_1': {
    'question':
        'The stranger\'s compliment makes you feel even more confident. What happens next?',
    'imagePrompt':
        'A person smiling brightly, surrounded by people of different backgrounds and appearances. The background is a vibrant city scene, full of life.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You embrace your uniqueness and continue to live your life authentically.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You realize that beauty is subjective and different people have different tastes.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_1_2': {
    'question':
        'You learn to ignore the stares and focus on your own happiness. What happens next?',
    'imagePrompt':
        'A person standing tall and proud, radiating confidence. The background is a scenic view of a majestic mountain range.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text': 'You discover that confidence is the key to true beauty.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You start to appreciate your own unique features and embrace your individuality.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_1': {
    'question':
        'You feel overwhelmed by the positive feedback and realize the power of social media. What happens next?',
    'imagePrompt':
        'A person speaking at a podium, addressing a crowd with passion and conviction. The background is a lively and diverse audience.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You use your platform to advocate for body positivity and self-acceptance.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You become consumed by the need for validation and approval, sacrificing your authenticity.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_2': {
    'question':
        'The negative comments hurt you deeply, but you decide to fight back. What happens next?',
    'imagePrompt':
        'A person standing up to a group of people, with a determined expression. The background is a tense and confrontational scene.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You use your experience to inspire others who face similar challenges.',
        'nextNode': 'end'
      },
      'b': {
        'text': 'You succumb to the negativity and lose your confidence.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_1': {
    'question':
        'You understand that true beauty comes from within, not from appearances. What happens next?',
    'imagePrompt':
        'A person meditating in a peaceful forest setting, surrounded by nature. The light is soft and warm, creating a tranquil atmosphere.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You focus on cultivating inner peace and self-love, finding happiness within.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You continue to seek external validation, feeling dissatisfied despite your newfound understanding.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_2': {
    'question':
        'You realize that your obsession with appearances is damaging your mental health. What happens next?',
    'imagePrompt':
        'A person sitting in a therapist\'s office, speaking openly about their struggles. The background is a comfortable and supportive environment.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You seek professional help to address your insecurities and find inner peace.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You continue to struggle with your self-image, feeling trapped in a cycle of self-destruction.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_1': {
    'question':
        'You learn that your worth is not defined by others\' opinions. What happens next?',
    'imagePrompt':
        'A person walking away from a crowd, with a determined expression. The background is a blurry image of a group of people, representing the pressures of society.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You break free from the need for external validation and embrace your individuality.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You continue to seek approval from others, hoping to finally feel accepted.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_2': {
    'question':
        'You feel more isolated and alone, struggling to find your place in the world. What happens next?',
    'imagePrompt':
        'A person sitting alone in a dark room, with a sad and defeated expression. The background is a gloomy cityscape, representing the feeling of loneliness.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You reach out for support and connect with others who share similar experiences.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You withdraw further into yourself, feeling hopeless and alone.',
        'nextNode': 'end'
      }
    }
  }
};

final Map<String, dynamic> vampireStoryBranches = {
  'start': {
    'question':
        'You find yourself alone with him under the full moon. His crimson eyes glow faintly, filled with both love and torment. He says, \n"I can no longer deny it—I thirst for you, in every possible way. Tell me, do you trust me enough to resist my darkest instincts?"',
    'imagePrompt':
        'A moonlit garden with two figures standing close together. One with glowing red eyes gazes intensely at the other, while shadows dance around them.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'You take a deep breath and reply, "I trust you with all my heart. I believe love can conquer even the darkest shadows within you."',
        'nextNode': 'question2a'
      },
      'b': {
        'text':
            'You hesitate, tears welling up in your eyes. "I want to trust you, but how can I be sure your love will always prevail over your thirst?"',
        'nextNode': 'question2b'
      }
    }
  },
  'question2a': {
    'question':
        'He pulls you closer, his cold touch sending shivers down your spine. "Then let me show you who I truly am," he whispers. "Would you accept immortality to be with me forever?"',
    'imagePrompt':
        'A intimate moment between two figures, one pale and ethereal, the other warm and human, surrounded by moonlit roses. The vampire\'s hand gently cups their lover\'s face.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Accept his offer of immortality, ready to embrace eternal love despite its dark nature.',
        'nextNode': 'question3a_1'
      },
      'b': {
        'text':
            'Choose to remain mortal, believing your humanity might be the bridge between your two worlds.',
        'nextNode': 'question3a_2'
      }
    }
  },
  'question2b': {
    'question':
        'His expression softens with understanding, but pain flickers in his eyes. "Then let me prove my love to you. Should I leave to protect you, or stay and fight against my nature?"',
    'imagePrompt':
        'A tortured vampire standing at a crossroads, torn between leaving and staying, while their loved one watches with concern in the background.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Ask him to stay and fight for your love, willing to face the risks together.',
        'nextNode': 'question3b_1'
      },
      'b': {
        'text':
            'Suggest a temporary separation until he gains better control over his thirst.',
        'nextNode': 'question3b_2'
      }
    }
  },
  'question3a_1': {
    'question':
        'The transformation is complete. You awaken to a world of heightened senses and immortal power. But your first hunger is overwhelming. How do you handle your new vampire nature?',
    'imagePrompt':
        'A newly turned vampire with glowing eyes, experiencing their first moments of immortality, surrounded by a swirling darkness and brilliant moonlight.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Embrace the traditional vampire way, hunting with your love but choosing only those who deserve judgment.',
        'nextNode': 'question4a_1_1'
      },
      'b': {
        'text':
            'Resist traditional feeding, seeking alternative sources of sustenance to maintain your humanity.',
        'nextNode': 'question4a_1_2'
      }
    }
  },
  'question3a_2': {
    'question':
        'Your mortality becomes both a blessing and a curse. Your blood calls to him more strongly each day, yet your human heart keeps him grounded. How do you navigate this delicate balance?',
    'imagePrompt':
        'A tender moment between mortal and vampire, as he gently holds their wrist, fighting his instincts while drawing strength from their love.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Offer small amounts of your blood regularly, trusting him to control himself.',
        'nextNode': 'question4a_2_1'
      },
      'b': {
        'text':
            'Maintain physical boundaries while strengthening your emotional bond.',
        'nextNode': 'question4a_2_2'
      }
    }
  },
  'question3b_1': {
    'question':
        'As days pass, his control wavers despite his best efforts. During an intimate moment, his fangs extend involuntarily. What do you do?',
    'imagePrompt':
        'A tense scene where the vampire struggles with his control, his fangs visible, while his lover must make a crucial decision.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Show absolute trust by staying still, letting him regain control on his own.',
        'nextNode': 'question4b_1_1'
      },
      'b': {
        'text':
            'Gently create distance, reminding him of your love but prioritizing safety.',
        'nextNode': 'question4b_1_2'
      }
    }
  },
  'question3b_2': {
    'question':
        'Months pass in separation. He returns, claiming to have found a way to control his thirst. But something about him seems different. How do you proceed?',
    'imagePrompt':
        'A reunion scene in a moonlit garden, where the vampire appears changed, his aura different, while his lover searches his eyes for truth.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Welcome him back completely, trusting that his change is genuine.',
        'nextNode': 'question4b_2_1'
      },
      'b': {
        'text':
            'Approach cautiously, asking him to prove his newfound control.',
        'nextNode': 'question4b_2_2'
      }
    }
  },
  'question4a_1_1': {
    'question':
        'Together, you\'ve become legendary among vampires - lovers who hunt the wicked. But now, a group of vampire hunters threatens your existence. What\'s your final choice?',
    'imagePrompt':
        'Two powerful vampires standing together against approaching hunters, their love evident in their protective stance.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Face the hunters together, proving that your love-guided path is righteous.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Flee to a new territory, preserving your love and chosen way of life.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_1_2': {
    'question':
        'Your unique path has inspired other vampires to seek alternatives. Will you become leaders in this revolutionary movement?',
    'imagePrompt':
        'A gathering of vampires looking to you and your love for guidance, while you stand together as pioneers of a new way.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Accept the role of leaders, working to change vampire society from within.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Choose a quiet life together, leading by example rather than active guidance.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_1': {
    'question':
        'Your blood bond has grown stronger, but also more dangerous. He warns that continued sharing might trigger an irreversible transformation. What now?',
    'imagePrompt':
        'An intimate scene where the vampire warns his lover about the consequences of their blood bond, their future hanging in the balance.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Accept the transformation, ready to join him in immortality through your shared blood bond.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Choose to end the blood sharing, preserving your mortality while keeping your love.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_2': {
    'question':
        'Your emotional bond has reached new depths, transcending physical limitations. But time moves forward, and mortality looms. What is your heart\'s final choice?',
    'imagePrompt':
        'An aging mortal and their eternally young vampire lover sharing a profound moment of decision under a starlit sky.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Embrace your mortality, finding beauty in your love\'s temporary nature.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Request the gift of immortality, ready to join him in eternal life.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_1': {
    'question':
        'Your trust helps him break through his struggle. He reveals an ancient ritual that could bind your souls, balancing his vampire nature. Do you take this final step?',
    'imagePrompt':
        'A mystical scene with ancient symbols glowing around the couple as they consider a soul-binding ritual.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Complete the soul-binding ritual, forever balancing his darkness with your light.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Maintain your separate natures, believing your love is strong enough without mystical bonds.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_2': {
    'question':
        'Your cautious approach has given him strength, but other vampires mock his restraint. How do you face this challenge together?',
    'imagePrompt':
        'A confrontation scene where other vampires challenge your lover\'s choices, while you stand united against their criticism.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Stand proudly together, letting your successful love story silence the critics.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Leave the vampire society behind, choosing a life away from their judgment.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_1': {
    'question':
        'His control comes from drinking powerful vampire blood. Now he offers you protection through the same means. What is your choice?',
    'imagePrompt':
        'A tense moment as the vampire reveals the dark source of his control, offering a vial of mysterious blood.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Accept the protection, trusting in your shared destiny despite the dark means.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Reject the blood, believing there must be a purer way to be together.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_2': {
    'question':
        'Your caution reveals he\'s now bound to a dangerous vampire coven. He begs you to flee together before they claim you too. What do you choose?',
    'imagePrompt':
        'A dramatic scene of the vampire warning his love about the approaching danger, offering an escape.',
    'imageUrl':
        'https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage12.png?alt=media&token=b761023d-6840-4495-9cc7-731c17206f2f',
    'options': {
      'a': {
        'text':
            'Run away together, leaving everything behind for a chance at free love.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'Stay and fight the coven together, refusing to let fear rule your love.',
        'nextNode': 'end'
      }
    }
  }
};
