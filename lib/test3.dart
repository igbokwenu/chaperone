import 'package:flutter/material.dart';

class HomeScreenG extends StatelessWidget {
  // Mock data mimicking Firebase data structure
  final List<Map<String, dynamic>> stories = [
    {
      "title": "Job Interview",
      "author": "Author",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage10.png?alt=media&token=73ff6db0-8a45-421f-8774-a73e3ac37749",
      "views": 32500,
      "likes": 27800,
      "comments": 6780
    },
    {
      "title": "Title of the scenario",
      "author": "Name of the Author",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/chaperonegame.firebasestorage.app/o/placeholder_images%2Fimage9.png?alt=media&token=3325b642-0ccf-419f-b6f7-2453a3844359",
      "views": 15000,
      "likes": 8000,
      "comments": 2300
    }
  ];

  HomeScreenG({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Discover",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.notifications_none, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  "3.580",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                story["imageUrl"],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        story["title"],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    story["author"],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text("${story["views"]}"),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.favorite,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text("${story["likes"]}"),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.comment,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text("${story["comments"]}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                              backgroundColor: Colors.blue,
                            ),
                            child: const Icon(Icons.play_arrow,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
