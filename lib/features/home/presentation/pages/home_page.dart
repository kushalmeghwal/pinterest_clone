import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/pages/pin_detail_page.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/widgets/pin_options_overlay.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

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
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pinterest",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
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
                        transitionDuration:
                            const Duration(milliseconds: 400),
                        pageBuilder: (_, _, _) =>
                            PinDetailPage(photo: photo),
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
    );
  }
}
