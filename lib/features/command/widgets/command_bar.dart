import 'package:flutter/material.dart';

class CommandBar extends StatefulWidget {
  final Function(String) onCommand;

  const CommandBar({super.key, required this.onCommand});

  @override
  State<CommandBar> createState() => _CommandBarState();
}

class _CommandBarState extends State<CommandBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _handleSubmit(String value) {
    if (value.isEmpty) return;
    
    // Convert to upper case to mimic Bloomberg style
    final command = value.toUpperCase().trim();
    
    // Trigger the action
    widget.onCommand(command);
    
    // Clear for next command
    _controller.clear();
    
    // Keep focus so user can keep typing
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF18181B), // Slightly lighter than background
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // The "Prompt" indicator
          const Text(
            "ORBIT > ",
            style: TextStyle(
              color: Color(0xFFF59E0B), // Amber color
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          // The Input Field
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true, // Always capture keyboard on load
              style: const TextStyle(
                color: Color(0xFFF59E0B), // Amber text
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: const Color(0xFFF59E0B),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Type a command (e.g. AAPL, TOP, NEWS)...",
                hintStyle: TextStyle(color: Colors.white24),
              ),
              onSubmitted: _handleSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
