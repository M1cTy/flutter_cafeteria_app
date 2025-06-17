import 'package:flutter/material.dart';

class CafeteriaMapPage extends StatelessWidget {
  const CafeteriaMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('学食マップ')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'キャンパス内の学食マップ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              // TODO: ここにマップ画像やウィジェットを追加
              const Icon(Icons.map, size: 120, color: Colors.blueGrey),
              const SizedBox(height: 16),
              const Text('※マップ画像や詳細は今後追加予定です', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
