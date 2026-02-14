import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinterest_clone/features/home/presentation/pages/home_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/search_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/inbox_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/user_profile_page.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_refresh_notifier.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchPage(),
    SizedBox(),
    InboxPage(),
    UserProfilePage(),
  ];

  void _onTap(int index) {
    if (index == 2) {
      _showCreateOverlay();
      return;
    }
    if (index == 0) {
      homeRefreshNotifier.value++;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  void _showCreateOverlay() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Create",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, _, _) {
        return Material(
          color: Colors.black.withValues(alpha: 0.4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.transparent),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _createOption(Icons.image, "Pin"),
                    _createOption(Icons.video_call, "Idea Pin"),
                    _createOption(Icons.link, "Board"),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _createOption(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 26),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: _currentIndex == 0 ? 34 : 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: _currentIndex == 1 ? 34 : 28),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 34),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: _currentIndex == 3 ? 34 : 28,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: _currentIndex == 4 ? 34 : 28),
            label: "",
          ),
        ],
      ),
    );
  }
}
