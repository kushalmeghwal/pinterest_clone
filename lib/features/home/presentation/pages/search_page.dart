import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/home/presentation/controllers/search_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<String> titles = [
    "Ideas for you",
    "Popular now",
    "Quick fashion",
    "Street style",
    "Home decor",
    "Travel ideas",
    "Dream rooms",
    "Hair inspiration",
    "Tattoo ideas",
  ];
  Future<void> _performSearch() async {
    FocusScope.of(context).unfocus(); // hide keyboard
    await ref.read(searchControllerProvider.notifier).loadInitial();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(searchControllerProvider.notifier).loadInitial();
    });

    _scrollController.addListener(() {
      final state = ref.read(searchControllerProvider);

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !state.isLoading) {
        ref.read(searchControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _sectionCount(state.photos.length) + 2,
          itemBuilder: (context, index) {
            if (index == 0) return _searchBar();

            if (index == _sectionCount(state.photos.length) + 1) {
              return state.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }

            return _section(state.photos, index - 1);
          },
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 10),

            Expanded(
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _performSearch(),
                decoration: const InputDecoration(
                  hintText: "Search for ideas",
                  border: InputBorder.none,
                ),
              ),
            ),

            GestureDetector(
              onTap: _performSearch,
              child: const Icon(Icons.camera_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(List photos, int sectionIndex) {
    final start = sectionIndex * 4;
    final end = start + 4;

    if (start >= photos.length) return const SizedBox();

    final sectionPhotos = photos.sublist(
      start,
      end > photos.length ? photos.length : end,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                const Text(
                  "Popular on Pinterest",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  titles[sectionIndex % titles.length],
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 2,
              itemCount: sectionPhotos.length,
              itemBuilder: (context, index) {
                final photo = sectionPhotos[index];

                final isLeft = index % 4 == 0;
                final isRight = index % 4 == 3;

                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: isLeft ? const Radius.circular(18) : Radius.zero,
                    bottomLeft: isLeft
                        ? const Radius.circular(18)
                        : Radius.zero,
                    topRight: isRight ? const Radius.circular(18) : Radius.zero,
                    bottomRight: isRight
                        ? const Radius.circular(18)
                        : Radius.zero,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: photo.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _sectionCount(int totalPhotos) {
    return (totalPhotos / 4).ceil();
  }
}
