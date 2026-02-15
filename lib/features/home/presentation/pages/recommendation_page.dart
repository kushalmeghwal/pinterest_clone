import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';

class RecommendationPage extends ConsumerStatefulWidget {
  const RecommendationPage({super.key});

  @override
  ConsumerState<RecommendationPage> createState() =>
      _RecommendationPageState();
}

class _RecommendationPageState
    extends ConsumerState<RecommendationPage> {
  final ScrollController _scrollController = ScrollController();
int _selectedTab = 0;

final List<String> _tabs = [
  "Pins",
  "Interests",
  "Boards",
  "Following",
  "Genres",
];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(homeControllerProvider.notifier).loadInitial();
    });

    _scrollController.addListener(() {
      final state = ref.read(homeControllerProvider);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !state.isLoading) {
        ref.read(homeControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Refine your recommendations",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       SizedBox(
  height: 44,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: _tabs.length,
    itemBuilder: (context, index) {
      final selected = index == _selectedTab;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _tabs[index],
                style: TextStyle(
                  color:
                      selected ? Colors.black : Colors.black54,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: selected ? 26 : 0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      );
    },
  ),
),


          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Hide Pins you've saved or viewed close up",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

          const SizedBox(height: 14),

          /// 🔹 GRID
          Expanded(
            child: MasonryGridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount:
                  state.photos.isEmpty ? 9 : state.photos.length,
              itemBuilder: (context, index) {
                if (state.photos.isEmpty) {
                  return Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  );
                }

                final PhotoModel photo = state.photos[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// PHOTO CARD
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: photo.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// eye-off overlay
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: .55),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// time text
                    Text(
                      "${(index + 1) * 2} hours ago",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;

  const _TabItem(this.title, [this.selected = false]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.white54,
              fontWeight:
                  selected ? FontWeight.bold : FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          if (selected)
            Container(
              height: 3,
              width: 26,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}
