import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CafeteriaStatus extends StatelessWidget {
  final int latestCongestion;
  final int userCount;
  final int avgStay;
  final List<int> congestionData;
  final List<String> timeLabels;

  const CafeteriaStatus({
    Key? key,
    required this.latestCongestion,
    required this.userCount,
    required this.avgStay,
    required this.congestionData,
    required this.timeLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String congestionLabel;
    Color labelColor;
    if (latestCongestion >= 80) {
      congestionLabel = 'とても混んでいます';
      labelColor = Colors.red;
    } else if (latestCongestion >= 50) {
      congestionLabel = 'やや混雑';
      labelColor = Colors.orange;
    } else if (latestCongestion >= 20) {
      congestionLabel = 'やや空いています';
      labelColor = Colors.green;
    } else {
      congestionLabel = '空いています';
      labelColor = Colors.blueAccent;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: labelColor, size: 14),
              const SizedBox(width: 8),
              Text(
                congestionLabel,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text('17時00分時点', style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text('利用者数: $userCount人', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 18),
              Icon(Icons.timer, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text('平均滞在: $avgStay分', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: LineChart(
                LineChartData(
                  maxY: 100,
                  minY: 0,
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          if (value % 50 == 0 &&
                              value != 0 &&
                              value >= 0 &&
                              value <= 100) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        interval: 50,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int idx = value.toInt();
                          if (idx % 2 == 0 &&
                              idx >= 0 &&
                              idx < timeLabels.length) {
                            return Text(
                              timeLabels[idx] + "時",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 24,
                        interval: 1,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        congestionData.length,
                        (i) =>
                            FlSpot(i.toDouble(), congestionData[i].toDouble()),
                      ),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                  ],
                  extraLinesData: ExtraLinesData(
                    verticalLines: [
                      () {
                        final hour = 17;
                        final minute = 0;
                        final index = (hour - 9) + (minute / 60);
                        if (index < 0 || index >= timeLabels.length)
                          return null;
                        return VerticalLine(
                          x: index,
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 2,
                          dashArray: null,
                          label: VerticalLineLabel(
                            show: true,
                            alignment: Alignment.topLeft,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            labelResolver: (line) => "Now",
                          ),
                        );
                      }(),
                    ].whereType<VerticalLine>().toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
