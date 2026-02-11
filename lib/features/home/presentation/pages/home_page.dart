import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/home/presentation/widgets/home.shimmer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAsync = ref.watch(homePhotosProvider);

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
      body: photoAsync.when(
        data: (photos) => MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 6,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: photo.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(height: 200, color: Colors.grey.shade200),
                fadeInDuration: const Duration(milliseconds: 300),
              ),
            );
          },
        ),
        loading: () => const HomeShimmer(),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
