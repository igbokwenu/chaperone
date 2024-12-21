import 'package:chaperone/view_models/story_card.dart';
import 'package:flutter/material.dart';

class StoryCarousel extends StatelessWidget {
  const StoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 600, // Adjust the height as needed
          child: PageView(
            controller: PageController(viewportFraction: 0.85),
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: StoryCard(
                  imageUrl:
                      'https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  title: 'High school life',
                  authorName: 'Name of the Author',
                  twitterHandle: '@author_twitter',
                  instagramHandle: '@author_instagram',
                  description:
                      'Sup, Park Jihoy\'s name is usually called Jihoy. His hobby is eating and playing games. Currently working as a streamer, he is interested in pro game players and streamers...',
                  followerCount: 1,
                  likeCount: 1,
                  commentCount: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: StoryCard(
                  imageUrl:
                      'https://images.pexels.com/photos/3622624/pexels-photo-3622624.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  title: 'Another Story',
                  authorName: 'Another Author',
                  twitterHandle: '',
                  instagramHandle: '@another_instagram',
                  description:
                      'This is another story card with different content.',
                  followerCount: 23,
                  likeCount: 54,
                  commentCount: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
