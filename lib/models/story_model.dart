import 'package:chaperone/utils/constants/constants.dart';

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
  final String? authorUsername;
  final String? authorDisplayname;
  final String? authorCountry;
  final String? authorState;
  final String? authorDevice;

  final bool? forMale;
  final bool? forFemale;
  final List<String>? followers;
  final List<String>? bookmarksList;
  final List<String>? favouritesList;
  final Map<String, dynamic>? storyData;
  final String? storyCreationPrompt;

  StoryModel({
    required this.storyUid,
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
    this.storyData,
    this.bookmarksList,
    this.favouritesList,
    this.authorUsername,
    this.authorDisplayname,
    this.storyCreationPrompt,
    this.authorCountry,
    this.authorState,
    this.authorDevice,
  });

  factory StoryModel.fromMap(Map<String, dynamic>? data) {
    return StoryModel(
      storyUid: data?[storyUidKey] ?? '',
      title: data?[storyTitleKey] ?? '',
      author: data?[storyAuthorKey] ?? '',
      thumbnailUrl: data?[storyThumbnailUrlKey] ?? '',
      isVerified: data?[storyIsVerifiedKey] ?? false,
      views: data?[storyViewsKey] ?? 0,
      likes: data?[storyLikesKey] ?? 0,
      comments: data?[storyCommentsKey] ?? 0,
      isBookmarked: data?[storyIsBookmarkedKey] ?? false,
      synopsis: data?[storySynopsisKey],
      question1: data?[storyQuestion1Key],
      questionOneImageUrl: data?[storyQuestionOneImageUrlKey],
      answer1a: data?[storyAnswer1aKey],
      answer1b: data?[storyAnswer1bKey],
      likeCount: data?[storyLikeCountKey],
      commentCount: data?[storyCommentCountKey],
      playCount: data?[storyPlayCountKey],
      likesUid: List<String>.from(data?[storyLikesUidKey] ?? []),
      shareCount: data?[storyShareCountKey],
      isPublished: data?[storyIsPublishedKey],
      isApproved: data?[storyIsApprovedKey],
      isRejected: data?[storyIsRejectedKey],
      isTrending: data?[storyIsTrendingKey],
      isBasedOnTrueStory: data?[storyIsBasedOnTrueStoryKey],
      isInspiredByTrueEvent: data?[storyIsInspiredByTrueEventKey],
      isForAdult: data?[storyIsForAdultKey],
      gameUid: data?[storyGameUidKey],
      description: data?[storyDescriptionKey],
      authorName: data?[storyAuthorNameKey],
      authorUid: data?[storyAuthorUidKey],
      forMale: data?[storyForMaleKey],
      forFemale: data?[storyForFemaleKey],
      followers: List<String>.from(data?[storyFollowersKey] ?? []),
      bookmarksList: List<String>.from(data?[storyBookmarksListKey] ?? []),
      favouritesList: List<String>.from(data?[storyFavouritesListKey] ?? []),
      storyData: data?[storyDataKey],
      authorUsername: data?[storyAuthorUsernameKey],
      authorDisplayname: data?[storyAuthorDisplayNameKey],
      storyCreationPrompt: data?[storyStoryCreationPromptKey],
      authorCountry: data?[userCountry],
      authorState: data?[userState],
      authorDevice: data?[userDevice],
    );
  }
}

final Map<String, dynamic> jobInterviewStoryBranches = {
  'start': {
    'question':
        'The hiring manager looks at you with a smile and asks: "So, are you married? Do you have plans to have children soon? How will you manage the demands of this job with family responsibilities?"',
    'imagePrompt':
        'A modern office setting, with a determined woman sitting across from a hiring manager. The room is filled with subtle tension, and the woman\'s expression is a mix of confidence and defiance.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You feel uncomfortable but decide to respond politely. "I\'d prefer to focus on my qualifications and how I can contribute to the company. My personal life should not impact my professional abilities."',
        'nextNode': 'question2a'
      },
      'b': {
        'text':
            'You smile and say "I am married and have plans to have children."',
        'nextNode': 'question2b'
      }
    }
  },
  'question2a': {
    'question':
        'The hiring manager leans forward, intrigued but skeptical. "That\'s a good answer, but this role requires a lot of dedication. How can you assure me that you\'re fully committed?"',
    'imagePrompt':
        'A close-up of the hiring manager\'s face, showing a mix of scrutiny and interest. The background is blurred, emphasizing the intensity of the moment.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You confidently explain your career goals and how they align with the company\'s vision, emphasizing your passion and commitment.',
        'nextNode': 'question3a_1'
      },
      'b': {
        'text':
            'You highlight your past achievements and ability to manage multiple responsibilities effectively, assuring them of your dedication.',
        'nextNode': 'question3a_2'
      }
    }
  },
  'question2b': {
    'question':
        'The hiring manager nods slowly, seemingly unconvinced. "Many women find it difficult to balance work and family. What makes you think you can handle it?"',
    'imagePrompt':
        'The woman in the interview now looks determined, with a backdrop of a bustling office and a family photo subtly placed to show the contrast.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You assert that your ability to manage your personal life is a strength and showcase your organizational skills.',
        'nextNode': 'question3b_1'
      },
      'b': {
        'text':
            'You challenge the assumption, stating that many men also balance work and family, and it\'s about individual capability, not gender.',
        'nextNode': 'question3b_2'
      }
    }
  },
  'question3a_1': {
    'question':
        'Your passion is evident, but the interviewer raises an eyebrow. "This industry is fast-paced and often requires overtime. How flexible are you with your time?"',
    'imagePrompt':
        'An image showing the woman passionately speaking, with the interviewer listening intently. The office background suggests a dynamic, fast-paced environment.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You express your willingness to work overtime when necessary, emphasizing your commitment to meeting deadlines and achieving results.',
        'nextNode': 'question4a_1_1'
      },
      'b': {
        'text':
            'You state your ability to manage your time efficiently, ensuring that you can handle the workload within regular hours while remaining flexible.',
        'nextNode': 'question4a_1_2'
      }
    }
  },
  'question3a_2': {
    'question':
        'The hiring manager seems impressed but probes further. "Your track record is strong, but have you ever faced a major professional setback, and how did you handle it?"',
    'imagePrompt':
        'A reflective image of the woman, deep in thought, with a backdrop that hints at past challenges and resilience.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You share a specific example of a professional setback, highlighting the lessons learned and how you turned it into an opportunity for growth.',
        'nextNode': 'question4a_2_1'
      },
      'b': {
        'text':
            'You discuss your proactive approach to problem-solving, emphasizing your ability to anticipate challenges and mitigate risks effectively.',
        'nextNode': 'question4a_2_2'
      }
    }
  },
  'question3b_1': {
    'question':
        'The interviewer seems to appreciate your organizational skills but remains concerned. "What if your child gets sick? How will you handle unexpected emergencies?"',
    'imagePrompt':
        'An image depicting a scenario of a working parent juggling work and a sick child, symbolizing the challenge of balancing responsibilities.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You explain your support system and contingency plans, ensuring minimal disruption to your work.',
        'nextNode': 'question4b_1_1'
      },
      'b': {
        'text':
            'You emphasize your commitment to both your family and your job, assuring them that you will find a way to manage both effectively.',
        'nextNode': 'question4b_1_2'
      }
    }
  },
  'question3b_2': {
    'question':
        'The hiring manager challenges you further. "This company values teamwork. How do you ensure your personal commitments won\'t interfere with team projects and deadlines?"',
    'imagePrompt':
        'An image of a diverse team working collaboratively, with the woman actively participating, illustrating her commitment to teamwork.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You describe your communication and collaboration skills, emphasizing your ability to coordinate effectively with team members.',
        'nextNode': 'question4b_2_1'
      },
      'b': {
        'text':
            'You highlight your proactive approach to planning and time management, ensuring that your personal commitments are well-managed and don\'t impact team goals.',
        'nextNode': 'question4b_2_2'
      }
    }
  },
  'question4a_1_1': {
    'question':
        'The interview is coming to a close. The hiring manager asks, "Why do you believe you are the best candidate for this position, considering all the challenges we\'ve discussed?"',
    'imagePrompt':
        'A confident image of the woman summarizing her qualifications, with the interviewer listening attentively. The office setting now feels more positive and hopeful.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You confidently summarize your unique qualifications, experiences, and unwavering commitment, emphasizing how you align perfectly with the company\'s needs and values.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You reiterate your passion for the industry and your proven ability to overcome challenges, positioning yourself as a resilient and dedicated candidate.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_1_2': {
    'question':
        'As the interview nears its end, the hiring manager asks, "How do you handle stress and pressure, especially when balancing personal and professional responsibilities?"',
    'imagePrompt':
        'An image showing the woman effectively managing a high-pressure situation, with a calm and composed demeanor. The background could include elements of both a busy office and a peaceful, stress-relieving setting.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You describe your stress-management techniques, such as mindfulness and prioritization, and how they help you maintain a healthy work-life balance.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You emphasize your resilience and ability to perform under pressure, citing examples of past situations where you successfully navigated stressful circumstances.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_1': {
    'question':
        'The hiring manager seems to value your growth mindset. "In this role, you\'ll face continuous learning and adaptation. How do you stay updated and adaptable in a rapidly changing industry?"',
    'imagePrompt':
        'An image depicting the woman engaging in continuous learning, such as attending a workshop or reading industry publications. The setting could be a modern, innovative workspace.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You discuss your commitment to continuous professional development, such as attending industry conferences, taking courses, and seeking mentorship.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You highlight your proactive approach to learning and your ability to quickly adapt to new technologies and methodologies, ensuring you remain at the forefront of industry trends.',
        'nextNode': 'end'
      }
    }
  },
  'question4a_2_2': {
    'question':
        'The interviewer appreciates your proactive approach. "This role requires strong leadership potential. Can you share an example of a time when you demonstrated leadership, especially in a challenging situation?"',
    'imagePrompt':
        'An image of the woman leading a team or project, showcasing her leadership skills in a challenging scenario. The setting could be a dynamic team meeting or a complex project environment.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You share a specific example of a time when you took initiative, motivated a team, and successfully navigated a challenging situation, highlighting your leadership qualities.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You discuss your leadership philosophy, emphasizing collaboration, empowerment, and leading by example, and how it has helped you achieve positive outcomes in past roles.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_1': {
    'question':
        'The hiring manager seems satisfied with your contingency plans. "However, this role requires a high level of attention to detail. How do you ensure accuracy in your work, especially when under pressure?"',
    'imagePrompt':
        'An image showcasing the woman\'s meticulous attention to detail, such as reviewing documents or using organizational tools. The setting could be a focused work environment with minimal distractions.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You describe your methods for ensuring accuracy, such as double-checking work, using checklists, and seeking feedback from colleagues.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You emphasize your ability to stay focused and organized under pressure, ensuring that your attention to detail remains consistent even in demanding situations.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_1_2': {
    'question':
        'The interviewer appreciates your balanced approach. "This company values innovation. How do you contribute to fostering an innovative work environment, especially while managing multiple responsibilities?"',
    'imagePrompt':
        'An image depicting the woman contributing to an innovative project or brainstorming session, showcasing her creative thinking and collaboration skills. The setting could be a modern, innovative workspace with creative elements.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You share examples of how you\'ve contributed to innovative projects in the past, highlighting your ability to think creatively and collaborate effectively with others.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You discuss your approach to fostering innovation, such as encouraging open communication, embracing new ideas, and continuously seeking ways to improve processes and outcomes.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_1': {
    'question':
        'The hiring manager values your communication skills. "In this role, you\'ll be working with diverse teams. How do you ensure effective communication and collaboration across different departments and personalities?"',
    'imagePrompt':
        'An image showcasing the woman effectively communicating and collaborating with a diverse team, highlighting her interpersonal skills. The setting could be a collaborative meeting or a team-building activity.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You describe your strategies for effective communication, such as active listening, clear and concise messaging, and adapting your communication style to different audiences.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You emphasize your ability to build strong relationships, foster a positive team environment, and facilitate collaboration across different departments and personalities.',
        'nextNode': 'end'
      }
    }
  },
  'question4b_2_2': {
    'question':
        'The interviewer appreciates your proactive planning. "This role involves representing the company externally. How do you ensure you represent the company\'s values and brand effectively in your interactions?"',
    'imagePrompt':
        'An image of the woman representing the company at an external event, such as a conference or a meeting with clients, showcasing her professionalism and alignment with the company\'s brand. The setting could be a professional external environment.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {
      'a': {
        'text':
            'You discuss your understanding of the company\'s values and brand, and how you embody them in your professional conduct, communication, and interactions.',
        'nextNode': 'end'
      },
      'b': {
        'text':
            'You share examples of how you\'ve successfully represented organizations in the past, highlighting your ability to build positive relationships and uphold professional standards.',
        'nextNode': 'end'
      }
    }
  },
  'end': {
    'question':
        'The interview concludes. The hiring manager smiles genuinely and says, "Thank you for your time. Your responses have been impressive. We\'ll be in touch soon." You leave the interview feeling confident and hopeful.',
    'imagePrompt':
        'A final image of the woman leaving the interview room with a confident and hopeful expression. The hiring manager is smiling and nodding, indicating a successful interview. The overall atmosphere is positive and optimistic.',
    'imageUrl':
        'https://chaperonegame.s3.us-east-1.amazonaws.com/logo/logo_only_4x_black_bg_512.png',
    'options': {}
  }
};
