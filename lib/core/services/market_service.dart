import 'dart:async';
import 'dart:math';
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
}
