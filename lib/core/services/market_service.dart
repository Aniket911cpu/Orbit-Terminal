import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import '../models/ticker.dart';

class MarketService {
  final _random = Random();
  final List<String> _symbols = ['AAPL', 'GOOGL', 'MSFT', 'AMZN', 'TSLA', 'BTC', 'ETH'];
  
  Stream<List<Ticker>> get tickerStream {
    return Stream.periodic(const Duration(milliseconds: 200), (_) {
      return _generateTickers();
    });
  }

  List<Ticker> _generateTickers() {
    return _symbols.map((symbol) {
      double price = 100 + _random.nextDouble() * 1000;
      double change = (_random.nextDouble() * 10) - 5;
      return Ticker(
        symbol: symbol,
        price: double.parse(price.toStringAsFixed(2)),
        change: double.parse(change.toStringAsFixed(2)),
      );
    }).toList();
  }

  List<FlSpot> getHistory(String symbol) {
    // Generate simulated 24h history (one point per hour roughly, or more granular)
    // For visual appeal, let's do 100 points
    final List<FlSpot> spots = [];
    double price = 150.0;
    for (int i = 0; i < 100; i++) {
      final change = (_random.nextDouble() * 4) - 2;
      price += change;
      spots.add(FlSpot(i.toDouble(), price));
    }
    return spots;
  }
}
