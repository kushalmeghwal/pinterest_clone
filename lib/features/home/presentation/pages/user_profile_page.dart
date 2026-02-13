import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedTab = 0;

  final List<String> tabs = ["Pins", "Boards", "Collages"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 TOP HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [

                  /// Profile Circle
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF0D5C4D),
                    child: Text(
                      "j",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 24),

                  /// Tabs
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(tabs.length, (index) {
                        final isSelected = _selectedTab == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTab = index;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                tabs[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (isSelected)
                                Container(
                                  height: 3,
                                  width: 40,
                                  color: Colors.black,
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 SEARCH BAR + PLUS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  /// Search Field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            "Search your Pins",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Icon(Icons.add, size: 30),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 FILTER CHIPS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  /// Grid Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.grid_view),
                  ),

                  const SizedBox(width: 12),

                  _chip("Favourites", Icons.star),

                  const SizedBox(width: 12),

                  _chip("Created by you", null),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 SAVED IMAGES ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _previewImage(),
                  const SizedBox(width: 10),
                  _previewImage(),
                  const SizedBox(width: 10),
                  _previewImage(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 COUNT TEXT
            const Center(
              child: Text(
                "3 Pins saved",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewImage() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          "https://picsum.photos/400",
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
