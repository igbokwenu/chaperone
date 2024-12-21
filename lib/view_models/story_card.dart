import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String authorName;
  final String twitterHandle;
  final String instagramHandle;
  final String description;
  final int followerCount;
  final int likeCount;
  final int commentCount;

  const StoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.authorName,
    required this.twitterHandle,
    required this.instagramHandle,
    required this.description,
    this.followerCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Bar (Hamburger Menu, Search, Notifications)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Handle menu
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // Handle search
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    // Handle notifications
                  },
                ),
              ],
            ),

            // Main Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16.0),

            // Title and Author
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4.0),
                const Icon(Icons.verified, color: Colors.blue, size: 18),
              ],
            ),
            Text(
              authorName,
              style: TextStyle(color: Colors.grey[400]),
            ),

            const SizedBox(height: 8.0),

            // Social Media Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (twitterHandle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset('assets/images/x.png',
                        height: 20,
                        width: 20), // Replace with your Twitter icon asset
                  ),
                if (instagramHandle.isNotEmpty)
                  Image.asset('assets/images/insta.png',
                      height: 20,
                      width: 20), // Replace with your Instagram icon asset
              ],
            ),

            const SizedBox(height: 16.0),

            // Description
            Text(
              description,
              style: TextStyle(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16.0),

            // Action Buttons (Pink, Chat, Start)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle start action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Start Game',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Follower, Like, Comment Counts
            _buildStatsIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsIndicator() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // The red rounded rectangle
        Container(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 25.0, left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // To make the row wrap content
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.person, followerCount),
              const SizedBox(width: 20),
              _buildStatItem(Icons.favorite, likeCount),
              const SizedBox(width: 20),
              _buildStatItem(Icons.comment, commentCount),
            ],
          ),
        ),
        // The small downward triangle
        Positioned(
          bottom: 10,
          child: CustomPaint(
            painter: TrianglePainter(
              strokeColor: Colors.red[400]!,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            size: const Size(20, 15),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Text('$count', style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

// Custom Painter for the triangle
class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x / 2, y)
      ..lineTo(x, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
