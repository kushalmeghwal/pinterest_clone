import 'package:flutter/material.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class PinDetailPage extends StatelessWidget {
  final PhotoModel photo;
  const PinDetailPage({super.key, required this.photo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: photo.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(photo.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
