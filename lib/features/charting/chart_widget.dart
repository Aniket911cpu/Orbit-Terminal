import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final List<FlSpot> spots;
  final String symbol;

  const ChartWidget({super.key, required this.spots, required this.symbol});

  @override
  Widget build(BuildContext context) {
    // Calculate min/max for dynamic Y-axis
    double minPrice = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxPrice = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    double padding = (maxPrice - minPrice) * 0.1;

    final bool isUp = (spots.last.y - spots.first.y) >= 0;
    final Color lineColor = isUp ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
      color: const Color(0xFF18181B),
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 8, left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              "CHART: $symbol",
              style: const TextStyle(
                color: Colors.white24,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) => const FlLine(color: Colors.white10, strokeWidth: 1),
                  getDrawingVerticalLine: (value) => const FlLine(color: Colors.white10, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      maxIncluded: false,
                      minIncluded: false,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 10,
                              fontFamily: 'JetBrains Mono',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: spots.length.toDouble() - 1,
                minY: minPrice - padding,
                maxY: maxPrice + padding,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          lineColor.withValues(alpha: 0.2),
                          lineColor.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
