import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF18181B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF27272A),
            width: double.infinity,
            child: const Text(
              "UNKNOWN WIRE",
              style: TextStyle(
                color: Color(0xFFF59E0B),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white12),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Market Update: Sector Analysis Report ${100 + index}",
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    "${index + 2}m ago",
                    style: const TextStyle(color: Colors.white24, fontSize: 11),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
