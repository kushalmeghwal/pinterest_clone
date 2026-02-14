import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/presentation/pages/comment_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/profile_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/share_page.dart';
import 'package:pinterest_clone/features/home/presentation/pages/user_profile_page.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/widgets/pin_option_sheet.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/widgets/pin_options_overlay.dart';

class PinDetailPage extends ConsumerStatefulWidget {
  final PhotoModel photo;

  const PinDetailPage({super.key, required this.photo});

  @override
  ConsumerState<PinDetailPage> createState() => _PinDetailPageState();
}

class _PinDetailPageState extends ConsumerState<PinDetailPage> {
  final ScrollController _scrollController = ScrollController();

  bool isLiked = false;
  bool isSaved = false;
  bool isAnimatingSave = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final state = ref.read(homeControllerProvider);

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !state.isLoading) {
        ref.read(homeControllerProvider.notifier).loadMore();
      }
    });
  }

  void _openPinOptions(PhotoModel photo) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "PinOptions",
      pageBuilder: (_, _, _) {
        return PinOptionsOverlay(photo: photo);
      },
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  void _showShareDialog(BuildContext context, PhotoModel photo) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Share",
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
      pageBuilder: (_, _, _) {
        return Material(
          color: Colors.black.withValues(alpha: 0.35),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.transparent),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, size: 26),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                "Share Pin link",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),

                      const SizedBox(height: 10),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: photo.imageUrl,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          _contactItem(photo.imageUrl, "Adam"),
                          const SizedBox(width: 16),
                          _contactAdd(),
                        ],
                      ),

                      const Divider(height: 28),

                      SizedBox(
                        height: 95, // controls overall height
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: const [
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: FontAwesomeIcons.whatsapp,
                                label: "WhatsApp",
                                color: Color(0xFF25D366),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: FontAwesomeIcons.link,
                                label: "Copy link",
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: FontAwesomeIcons.telegram,
                                label: "Telegram",
                                color: Color(0xFF2AABEE),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: Icons.mail,
                                label: "Gmail",
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: FontAwesomeIcons.snapchat,
                                label: "Snapchat",
                                color: Colors.yellow,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: SharePage(
                                icon: Icons.more_horiz,
                                label: "More",
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _contactItem(String image, String name) {
    return Column(
      children: [
        CircleAvatar(radius: 28, backgroundImage: NetworkImage(image)),
        const SizedBox(height: 6),
        Text(name),
      ],
    );
  }

  Widget _contactAdd() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFFE9E9E9),
          child: Icon(Icons.person_add_alt_1),
        ),
        SizedBox(height: 6),
        Text("Search"),
      ],
    );
  }

void _showPinOptions(BuildContext context, String photographer) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => PinOptionsSheet(photographer: photographer),
  );
}

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Hero(
                            tag: widget.photo.id,
                            child: CachedNetworkImage(
                              imageUrl: widget.photo.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 20),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CommentPage(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            size: 26,
                          ),
                        ),

                        const SizedBox(width: 20),

                        GestureDetector(
                          onTap: () {
                            _showShareDialog(context, widget.photo);
                          },
                          child: const Icon(Icons.share_outlined, size: 26),
                        ),

                        const SizedBox(width: 20),

                        GestureDetector(
                          onTap: () {
                            _showPinOptions(context, widget.photo.photographer);
                          },
                          child: const Icon(Icons.more_horiz, size: 26),
                        ),

                        const Spacer(),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSaved
                                ? Colors.black87
                                : Colors.red,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 26,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () async {
                            if (isSaved && !isAnimatingSave) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const UserProfilePage(),
                                ),
                              );
                              return;
                            }

                            if (!isSaved) {
                              setState(() {
                                isSaved = true;
                                isAnimatingSave = true;
                              });

                              await Future.delayed(
                                const Duration(milliseconds: 1500),
                              );

                              setState(() {
                                isAnimatingSave = false;
                              });
                            }
                          },
                          child: Text(
                            isSaved
                                ? (isAnimatingSave ? "Saved" : "Profile")
                                : "Save",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfilePage(
                              photographer: widget.photo.photographer,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 18),
                          const SizedBox(width: 12),
                          Text(
                            widget.photo.photographer,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "More to explore",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  MasonryGridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 6,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    itemCount: state.photos.length,
                    itemBuilder: (context, index) {
                      final photo = state.photos[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PinDetailPage(photo: photo),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: photo.imageUrl,
                                fit: BoxFit.cover,
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

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
