import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../command/widgets/command_bar.dart';
import '../../../core/services/market_service.dart';
import '../../../core/models/ticker.dart';
import 'widgets/ticker_tile.dart';
import 'widgets/news_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MarketService _marketService = MarketService();
  String _lastCommand = "";

  void _handleCommand(String command) {
    setState(() {
      _lastCommand = command;
      // In a real app, logic to switch views would go here.
      // For MVP, we just verify input processing.
      print("Command received: $command");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommandBar(onCommand: _handleCommand),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: StreamBuilder<List<Ticker>>(
              stream: _marketService.tickerStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tickers = snapshot.data!;
                
                return StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    // TOP ROW: Tickers
                    ...tickers.take(4).map((ticker) => StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: TickerTile(ticker: ticker),
                    )),
                    
                    // MAIN CHART AREA
                    StaggeredGridTile.count(
                      crossAxisCellCount: 3,
                      mainAxisCellCount: 2,
                      child: Container(
                        color: const Color(0xFF18181B),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "CHART: AAPL US EQUITY", 
                              style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold),
                            ),
                            if (_lastCommand.isNotEmpty)
                              Text(
                                "Last Command: $_lastCommand",
                                style: const TextStyle(color: Color(0xFFF59E0B)),
                              )
                          ],
                        ),
                      ),
                    ),

                    // NEWS FEED (Sidebar)
                    const StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 2,
                      child: NewsTile(),
                    ),
                    
                    // BOTTOM ROW: More Tickers
                     ...tickers.skip(4).take(3).map((ticker) => StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: TickerTile(ticker: ticker),
                    )),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
