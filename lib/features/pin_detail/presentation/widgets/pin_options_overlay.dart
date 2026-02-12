import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class PinOptionsOverlay extends StatelessWidget {
  final PhotoModel photo;
  
  const PinOptionsOverlay({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      child: Stack(
        children: [
         
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.transparent),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                 
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                       
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      "This Pin was inspired by your recent activity",
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          _optionItem(Icons.push_pin_outlined, "Save"),
                          _optionItem(Icons.share_outlined, "Share"),
                          _optionItem(
                            Icons.download_outlined,
                            "Download image",
                          ),
                          _optionItem(
                            Icons.favorite_border,
                            "See more like this",
                          ),
                          _optionItem(
                            Icons.visibility_off_outlined,
                            "See less like this",
                          ),
                          
                          _optionItem(
                            Icons.report_outlined,
                            "Report Pin",
                            subtitle:
                                "This goes against Pinterest's \nCommunity Guidelines",
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: -constraints.maxHeight * 0.15,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: CachedNetworkImage(
                            imageUrl: photo.imageUrl,
                            width: constraints.maxWidth * 0.32,
                            height: constraints.maxHeight * 0.23,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 12,
                      left: 12,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 26),
                        onPressed: () => Navigator.pop(context),
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

  Widget _optionItem(IconData icon, String text, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 23),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
            
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    
                    child: Text(
                      
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
