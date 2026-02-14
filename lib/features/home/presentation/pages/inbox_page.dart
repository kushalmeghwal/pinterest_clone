import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Inbox",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// 🔹 MESSAGES TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Messages",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 PINTEREST MESSAGE
              _messageTile(
                avatar: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFFE60023),
                  child: Icon(Icons.push_pin, color: Colors.white, size: 28),
                ),
                title: "Pinterest India",
                subtitle:
                    "Then, just click the share icon next to any Pin to send it in a message....",
                trailing: "3y",
              ),

              const SizedBox(height: 16),

              /// 🔹 FIND PEOPLE
              _messageTile(
                avatar: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFFE9E9E9),
                  child: Icon(Icons.person_add_alt_1, size: 28),
                ),
                title: "Find people to message",
                subtitle: "Connect to start chatting",
              ),

              const SizedBox(height: 30),

              /// 🔹 UPDATES
              const Text(
                "Updates",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 UPDATE CARD
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE9E9E9),
                    child: Icon(Icons.add, size: 30),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "What ideas feel jessy? Create your first Pin to share what inspires you.",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "3h",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.more_horiz, size: 28),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 MESSAGE TILE
  Widget _messageTile({
    required Widget avatar,
    required String title,
    required String subtitle,
    String? trailing,
  }) {
    return Row(
      children: [
        avatar,
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),

        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(color: Colors.black54),
          ),
      ],
    );
  }
}
