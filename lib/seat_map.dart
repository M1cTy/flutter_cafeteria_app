import 'package:flutter/material.dart';

class SeatMap extends StatelessWidget {
  /// 0: なし, 1: 空席, 2: 使用中
  final List<List<int>> seatMatrix;
  final void Function(int row, int col)? onTap;

  const SeatMap({super.key, required this.seatMatrix, this.onTap});

  @override
  Widget build(BuildContext context) {
    final rowCount = seatMatrix.length;
    final colCount = seatMatrix.isNotEmpty ? seatMatrix[0].length : 0;
    const double seatSize = 18; // サイズを縮小
    const double seatPadding = 2; // パディングも縮小

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 24,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LegendCircle(
                    color: Colors.white,
                    borderColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 4),
                  const Text('空席', style: TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LegendCircle(
                    color: Colors.grey.shade300,
                    borderColor: Colors.red.shade300,
                  ),
                  const Icon(Icons.close, color: Colors.red, size: 14),
                  const SizedBox(width: 4),
                  const Text('使用中', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(rowCount, (row) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(colCount, (col) {
                    final seatType = seatMatrix[row][col];
                    Color borderColor = Colors.grey.shade300;
                    Color fillColor = Colors.white;
                    Widget? child;
                    bool isEnabled = false;
                    if (seatType == 1) {
                      // 空席
                      isEnabled = true;
                    } else if (seatType == 2) {
                      // 使用中
                      fillColor = Colors.grey.shade300;
                      borderColor = Colors.red.shade300;
                      child = const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 14,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(seatPadding),
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: isEnabled && onTap != null
                              ? () => onTap!(row, col)
                              : null,
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: seatSize,
                            height: seatSize,
                            decoration: BoxDecoration(
                              color: seatType == 0
                                  ? Colors.transparent
                                  : fillColor,
                              shape: BoxShape.circle,
                              border: seatType == 0
                                  ? null
                                  : Border.all(color: borderColor, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: child,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendCircle extends StatelessWidget {
  final Color color;
  final Color borderColor;
  const _LegendCircle({required this.color, required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1),
      ),
    );
  }
}
