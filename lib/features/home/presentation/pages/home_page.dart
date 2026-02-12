import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/pages/pin_detail_page.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/widgets/pin_options_overlay.dart';
import 'package:pinterest_clone/features/home/presentation/pages/recommendation_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/search_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/inbox_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/user_profile_page.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(homeControllerProvider.notifier).loadInitial();
    });

    _scrollController.addListener(() {
      final currentState = ref.read(homeControllerProvider);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !currentState.isLoading) {
        ref.read(homeControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showCreateOverlay() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Create",
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.black.withValues(alpha: 0.4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Blur background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.transparent),
              ),

              /// White Create Box
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

  void _openPinOptions(PhotoModel photo) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "PinOptions",
      pageBuilder: (_, __, ___) {
        return PinOptionsOverlay(photo: photo);
      },
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  void _onBottomTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        ref.read(homeControllerProvider.notifier).loadInitial();
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchPage()),
        );
        break;
      case 2:
        _showCreateOverlay();
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InboxPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserProfilePage()),
        );
        break;
    }
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
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "For you",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RecommendationPage()),
              );
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(homeControllerProvider.notifier).loadInitial();
        },
        child: MasonryGridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 12,
          crossAxisSpacing: 6,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          itemCount: state.photos.isEmpty ? 10 : state.photos.length + 1,
          itemBuilder: (context, index) {
            if (state.photos.isEmpty) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: (index % 2 == 0) ? 200 : 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            }

            if (index == state.photos.length) {
              return state.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }

            final photo = state.photos[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, _, _) => PinDetailPage(photo: photo),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: photo.id,
                      child: CachedNetworkImage(
                        imageUrl: photo.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz, size: 20),
                    onPressed: () => _openPinOptions(photo),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
