import 'package:flutter/material.dart';
import '../../../core/models/ticker.dart';

class TickerTile extends StatelessWidget {
  final Ticker ticker;

  const TickerTile({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    final isUp = ticker.change >= 0;
    final color = isUp ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
      color: const Color(0xFF18181B),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ticker.symbol,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ticker.price.toStringAsFixed(2),
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          Text(
            "${isUp ? '+' : ''}${ticker.change.toStringAsFixed(2)}%",
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
