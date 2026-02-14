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
    transitionDuration: const Duration(milliseconds: 250),
    transitionBuilder: (_, animation, _, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: child,
      );
    },
    pageBuilder: (_, _, _) {
      return Material(
        color: Colors.black.withValues(alpha: 0.35),
        child: Stack(
          children: [

            /// 🔹 BLUR BACKGROUND
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),

            /// 🔹 BOTTOM SHEET
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// 🔹 TOP ROW
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, size: 26),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Start creating now",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40), // balance center
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// 🔹 OPTIONS ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _createSquareOption(Icons.push_pin_outlined, "Pin"),
                        _createSquareOption(Icons.auto_fix_high, "Collage"),
                        _createSquareOption(Icons.dashboard_outlined, "Board"),
                      ],
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _createSquareOption(IconData icon, String label) {
  return Column(
    children: [
      Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(icon, size: 34),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
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
