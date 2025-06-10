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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(rowCount, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(colCount, (col) {
              final seatType = seatMatrix[row][col];
              if (seatType == 0) {
                return const SizedBox(width: 28, height: 28); // サイズを小さく
              }
              Color borderColor = Colors.grey.shade300;
              Color fillColor = Colors.white;
              Widget? child;
              if (seatType == 2) {
                fillColor = Colors.grey.shade300;
                borderColor = Colors.red.shade300;
                child = const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 14,
                ); // アイコンも小さく
              }
              return Padding(
                padding: const EdgeInsets.all(3), // パディングも小さく
                child: PhysicalModel(
                  color: fillColor,
                  elevation: 3,
                  shape: BoxShape.circle,
                  shadowColor: const Color.fromARGB(
                    255,
                    197,
                    197,
                    197,
                  ).withOpacity(0.2),
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: FloatingActionButton(
                      heroTag: 'seat_${row}_$col',
                      onPressed: seatType == 1 && onTap != null
                          ? () => onTap!(row, col)
                          : null,
                      backgroundColor: fillColor,
                      elevation: 0,
                      shape: CircleBorder(side: BorderSide(color: borderColor)),
                      child: child,
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
