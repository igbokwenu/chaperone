import 'package:cached_network_image/cached_network_image.dart';
import 'package:chaperone/models/story_model.dart';
import 'package:chaperone/services/auth_service.dart';
import 'package:chaperone/services/database_service.dart';
import 'package:chaperone/utils/constants/constants.dart';
import 'package:chaperone/utils/reusable_functions.dart';
import 'package:chaperone/utils/reusable_widgets.dart';
import 'package:chaperone/views/story_preview_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final StoryModel scenario;

  const StoryCard({
    super.key,
    required this.scenario,
  });

  @override
  Widget build(BuildContext context) {
    const double kDefaultPadding = 12;
    final authService = AuthService();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final databaseService = DatabaseService(uid: scenario.storyUid);
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'story-image-${scenario.storyUid}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  child: kIsWeb
                      ? Image.network(
                          scenario.thumbnailUrl,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: scenario.thumbnailUrl,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const ChaperoneLogoImageWidget(),
                        ),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      if (scenario.favouritesList!.contains(firebaseUser.uid)) {
                        await databaseService.updateAnyStoriesData(
                          fieldName: storyFavouritesListKey,
                          newValue: FieldValue.arrayRemove([firebaseUser.uid]),
                        );

                        MyReusableFunctions.showCustomToast(
                          description:
                              "${scenario.storyData![storyTitleKey]} has been removed from your favorites list",
                        );
                      } else {
                        await databaseService.updateAnyStoriesData(
                          fieldName: storyFavouritesListKey,
                          newValue: FieldValue.arrayUnion([firebaseUser.uid]),
                        );
                        MyReusableFunctions.showCustomToast(
                          description:
                              "${scenario.storyData![storyTitleKey]} has been added to your favorites list",
                        );
                      }
                    },
                    icon: Icon(
                      scenario.favouritesList!.contains(firebaseUser!.uid)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              scenario.storyData![storyTitleKey],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By ${scenario.authorDisplayname}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildGlossyStat(Icons.visibility_outlined,
                            _formatNumber(scenario.views)),
                        const SizedBox(width: 12),
                        _buildGlossyStat(
                            scenario.favouritesList!.contains(firebaseUser.uid)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            _formatNumber(scenario.favouritesList!.length)),
                        const SizedBox(width: 12),
                        _buildGlossyStat(
                            Icons.play_arrow_rounded,
                            _formatNumber(scenario.playCount!),
                            scenario.bookmarksList!.contains(firebaseUser.uid)
                                ? Colors.blue
                                : Colors.white70),
                        const Spacer(),
                        if (MyReusableFunctions.isAdmin(firebaseUser.email!))
                          IconButton(
                            onPressed: () async {
                              MyReusableFunctions.showCustomDialog(
                                  context: context,
                                  dialogIconColor: Colors.red,
                                  message:
                                      'Are you sure you want to delete ${scenario.storyData![storyTitleKey]}? This cannot be reversed! 💀',
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await authService.deleteStoryDoc(
                                            scenario.storyUid,
                                            scenario.storyData![storyTitleKey]);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  ]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () async {
                            await databaseService.updateAnyStoriesData(
                              fieldName: storyViewsKey,
                              newValue: FieldValue.increment(1),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoryPreviewCard(scenario: scenario),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Play'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlossyStat(IconData icon, String value, [Color? color]) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color ?? Colors.white70,
        ),
        const SizedBox(width: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
