import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../command/widgets/command_bar.dart';
import '../../../core/services/market_service.dart';
import '../../../core/models/ticker.dart';
import '../widgets/ticker_tile.dart';
import '../widgets/news_tile.dart';
import '../../charting/chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MarketService _marketService = MarketService();
  String _lastCommand = "AAPL";
  List<FlSpot> _chartHistory = [];

  @override
  void initState() {
    super.initState();
    _updateChart("AAPL");
  }

  void _updateChart(String symbol) {
     setState(() {
       _lastCommand = symbol;
       _chartHistory = _marketService.getHistory(symbol);
     });
  }

  void _handleCommand(String command) {
    // Basic validation: if length < 5 assume it's a ticker
    if (command.length <= 5) {
      _updateChart(command);
    } else {
      setState(() {
        _lastCommand = command; // For non-ticker commands
      });
    }
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
                      child: _chartHistory.isNotEmpty 
                        ? ChartWidget(spots: _chartHistory, symbol: _lastCommand)
                        : Container(
                        color: const Color(0xFF18181B),
                        alignment: Alignment.center,
                        child: const Text("NO DATA"),
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
