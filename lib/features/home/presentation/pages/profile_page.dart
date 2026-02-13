import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 COVER IMAGE WITH BACK + SHARE
              Stack(
                children: [

                  Image.network(
                    "https://picsum.photos/800/400",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: Row(
                      children: const [
                        Icon(Icons.share, color: Colors.white),
                        SizedBox(width: 16),
                        Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 PROFILE INFO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [

                    const CircleAvatar(
                      radius: 36,
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),

                    const SizedBox(width: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "education",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "rabiakhanrabia788",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 FOLLOWERS TEXT
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "765 followers · 1 following · 8.3m monthly views",
                  style: TextStyle(fontSize: 15),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 FOLLOW BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 🔹 TABS (Created / Saved)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _tab("Created", 0),
                  const SizedBox(width: 40),
                  _tab("Saved", 1),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 6,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "https://picsum.photos/400?random=$index",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(String title, int index) {
    final bool isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          if (isSelected)
            Container(
              height: 3,
              width: 70,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
