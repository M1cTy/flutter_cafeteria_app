import 'package:flutter/material.dart';

class CafeteriaMapPage extends StatelessWidget {
  const CafeteriaMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('学食マップ'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map), text: 'マップ'),
              Tab(icon: Icon(Icons.info_outline), text: '詳細'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // マップタブ
            Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'キャンパス内の学食マップ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    Icon(Icons.map, size: 120, color: Colors.blueGrey),
                    SizedBox(height: 16),
                    Text('※マップ画像や詳細は今後追加予定です', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            // 詳細タブ
            Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'ここに学食の詳細情報を追加できます',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
