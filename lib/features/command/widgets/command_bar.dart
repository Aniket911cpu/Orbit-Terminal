import 'package:flutter/material.dart';

class CommandBar extends StatefulWidget {
  final Function(String) onCommand;

  const CommandBar({super.key, required this.onCommand});

  @override
  State<CommandBar> createState() => _CommandBarState();
}

class _CommandBarState extends State<CommandBar> {
  final FocusNode _focusNode = FocusNode();
  
  // Simulated Command/Ticker Database
  static const List<String> _kOptions = <String>[
    'AAPL', 'AMZN', 'GOOGL', 'MSFT', 'TSLA', 'BTC', 'ETH',
    'TOP', 'NEWS', 'SETTINGS', 'HELP', 'LOGOUT'
  ];

  void _handleSubmit(String value) {
    if (value.isEmpty) return;
    final command = value.toUpperCase().trim();
    widget.onCommand(command);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF18181B),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text(
            "ORBIT > ",
            style: TextStyle(
              color: Color(0xFFF59E0B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _kOptions.where((String option) {
                  return option.startsWith(textEditingValue.text.toUpperCase());
                });
              },
              onSelected: (String selection) {
                _handleSubmit(selection);
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                // Sync internal focus node if needed, or just use the one provided
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  autofocus: true,
                  style: const TextStyle(
                    color: Color(0xFFF59E0B),
                    fontSize: 16, // Matching previous style
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: const Color(0xFFF59E0B),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a command...",
                    hintStyle: TextStyle(color: Colors.white24),
                  ),
                  onSubmitted: _handleSubmit,
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    color: const Color(0xFF27272A),
                    child: Container(
                      width: 300,
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              onSelected(option);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Text(
                                option,
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontFamily: 'JetBrains Mono',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
