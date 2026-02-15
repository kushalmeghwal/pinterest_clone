import 'package:flutter/material.dart';
import 'package:pinterest_clone/core/utils/main_navigation_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedTab = 0;
  final List<String> tabs = ["Pins", "Boards", "Collages"];

  final TextEditingController _searchController = TextEditingController();

  /// 🔹 navigate to homepage
  void _goToHomePage() {
    MainNavigationPage.switchTab(context,0);
  }

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
                  /// ✅ PROFILE ICON (changed from "j")
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF0D5C4D),
                    child: Icon(Icons.person, color: Colors.white, size: 28),
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
                  /// ✅ Search Field (now editable)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: "Search your Pins",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// ✅ + icon calls overlay
                  GestureDetector(
                    onTap: () {
                      MainNavigationPage.switchTab(context,2);
                    },
                    child: const Icon(Icons.add, size: 30),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 EMPTY STATE IMAGE (matches screenshot)
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: const NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/2331/2331940.png",
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Save what inspires you",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: Text(
                  "Saving Pins is Pinterest’s superpower.\n"
                  "Browse Pins, save what you love, find\n"
                  "them here to get inspired all over\nagain.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// ✅ Explore button → homepage
            Center(
              child: ElevatedButton(
                onPressed: _goToHomePage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Explore Pins",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
