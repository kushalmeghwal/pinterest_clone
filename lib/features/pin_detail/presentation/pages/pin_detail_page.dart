import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class PinDetailPage extends StatelessWidget {
  final PhotoModel photo;

  const PinDetailPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 IMAGE SECTION
              Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Hero(
                        tag: photo.id,
                        child: CachedNetworkImage(
                          imageUrl: photo.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Back Button
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    // Floating Share Button
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 ACTION ROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [

                    const Icon(Icons.favorite_border, size: 28),
                    const SizedBox(width: 20),
                    const Icon(Icons.chat_bubble_outline, size: 26),
                    const SizedBox(width: 20),
                    const Icon(Icons.share_outlined, size: 26),
                    const SizedBox(width: 20),
                    const Icon(Icons.more_horiz, size: 26),

                    const Spacer(),

                    // Save Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 CREATOR SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 18),
                    const SizedBox(width: 10),
                    Text(
                      photo.photographer,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 TITLE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "6 January 2026",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 HASHTAG
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "#Sharmili Baruah",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 CAPTION
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "\"His blessings are with us....😊\"  View comment",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "More to explore",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Placeholder Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: photo.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
