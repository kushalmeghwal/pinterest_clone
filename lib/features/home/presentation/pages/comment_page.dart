import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final String photographer;

  const CommentPage({super.key, required this.photographer});
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    super.initState();

    _commentController.addListener(() {
      setState(() {
        hasText = _commentController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔹 TOP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          widget.photographer,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Icon(Icons.share_outlined, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 10),

                const Text(
                  "25 comments",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                _commentItem(
                  avatarColor: Colors.pink.shade100,
                  name: "Pari",
                  subtitle: "asked a question 👀 • 06/24",
                  comment: "What is the name of the movie?",
                  likes: "1",
                  showReplies: "Show 7 replies",
                ),

                _commentItem(
                  image: "https://i.pravatar.cc/150?img=3",
                  name: "detective",
                  subtitle: "11/25",
                  comment: "Fight club",
                ),

                _commentItem(
                  image: "https://i.pravatar.cc/150?img=8",
                  name: "roshan",
                  subtitle: "03/25",
                  comment:
                      "This movie looks fire i wonder what must be it’s name",
                  showReplies: "Show 2 replies",
                ),

                _commentItem(
                  image: "https://i.pravatar.cc/150?img=5",
                  name: "Anand",
                  subtitle: "02/25",
                  comment:
                      "The first rule of fight club is don't talk about fight club",
                  showReplies: "Show 1 reply",
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),

          _bottomCommentBar(),
        ],
      ),
    );
  }

  Widget _commentItem({
    String? image,
    Color? avatarColor,
    required String name,
    required String subtitle,
    required String comment,
    String? likes,
    String? showReplies,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: avatarColor ?? Colors.grey.shade300,
                backgroundImage: image != null ? NetworkImage(image) : null,
                child: image == null
                    ? const Text("م", style: TextStyle(color: Colors.black))
                    : null,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "$name ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: subtitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(comment, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Text(
                          "Reply",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.favorite_border, size: 18),
                        if (likes != null) ...[
                          const SizedBox(width: 4),
                          Text(likes),
                        ],
                        const SizedBox(width: 16),
                        const Icon(Icons.more_horiz, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (showReplies != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Container(width: 32, height: 2, color: Colors.black),
                const SizedBox(width: 10),
                Text(
                  showReplies,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// 🔹 BOTTOM BAR
  Widget _bottomCommentBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _reaction("👀", isWide: true),
              _reaction("👏", isWide: true),
              _reaction("🔥", isWide: true),
              _reaction("📌", isWide: true),
              _reaction("Love it! ❤️", isWide: true),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: "Add a comment",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Icon(Icons.emoji_emotions_outlined),
                const SizedBox(width: 12),
                const Icon(Icons.image_outlined),

                const SizedBox(width: 8),

                GestureDetector(
                  onTap: hasText
                      ? () {
                          _commentController.clear();
                        }
                      : null,
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: hasText ? Colors.red : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: Colors.white,
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

  Widget _reaction(String text, {bool isWide = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 14 : 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
