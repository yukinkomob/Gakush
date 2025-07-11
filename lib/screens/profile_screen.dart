import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // fl_chartをインポート
import './calendar_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // ダミーデータ for 週間レポート (折れ線グラフ)
  final List<FlSpot> weeklyReportData = [
    const FlSpot(0, 1.0),
    const FlSpot(1, 2.0),
    const FlSpot(2, 1.5),
    const FlSpot(3, 2.5),
    const FlSpot(4, 2.0),
    const FlSpot(5, 3.0),
    const FlSpot(6, 2.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''), // ここにタイトルバーを追加
      ),
      backgroundColor: Colors.grey[50], // 全体の背景色
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0, // アバターとレーダーチャートの高さ
            floating: false,
            pinned: false, // スクロールしてもAppbarは固定しない
            backgroundColor: Colors.transparent, // AppBarの背景を透明に
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bubble.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30), // 丸みを帯びた角
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    // アバター画像
                    Positioned(
                      top: 8, // 適切な位置に調整
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hanako', // 名前
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // 名前と背景色のコントラストを考慮
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 100, // アバターの幅
                            height: 150, // アバターの高さ (画像の縦横比を参考に調整)
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(
                                    'assets/images/avatar1.png'), // プレースホルダー画像
                                fit: BoxFit.contain,
                              ),
                              borderRadius: BorderRadius.circular(10), // 角を丸く
                            ),
                          ),
                        ],
                      ),
                    ),
                    // レーダーチャート
                    Positioned(
                      top: 30, // 適切な位置に調整
                      right: 20,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5, // 画面幅の半分程度
                        height: 200,
                        child: RadarChart(
                          RadarChartData(
                            dataSets: [
                              RadarDataSet(
                                fillColor: Colors.blue.withOpacity(0.5), // 塗りつぶし色
                                borderColor: Colors.transparent, // 枠線色
                                borderWidth: 3,
                                entryRadius: 0, // 各点の半径
                                dataEntries: [4.0, 4.5, 4.0, 4.2, 5.0, 4.3].map((value) {
                                  return RadarEntry(value: value);
                                }).toList(),
                              ),
                            ],
                            radarBackgroundColor: Colors.blue.shade100,
                            tickBorderData: const BorderSide(
                                color: Colors.white, width: 2),
                            // グリッド線の設定
                            radarBorderData: const BorderSide(
                                color: Colors.white, width: 2),
                            radarShape: RadarShape.polygon,
                            gridBorderData: const BorderSide(
                                color: Colors.white, width: 2),
                            // タイトル
                            getTitle: (index, angle) {
                              final titles = [
                                '主体性',
                                '好奇心',
                                '活発性',
                                '柔軟性',
                                '戦略性',
                                '協調性'
                              ];
                              return RadarChartTitle(
                                text: titles[index],
                              );
                            },
                            // スケール
                            tickCount: 5, // 目盛りの数
                            ticksTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 0), // 目盛り数字を非表示
                            // 最大値
                            // max: 5, // レーダーチャートの最大値
                          ),
                          swapAnimationDuration: Duration.zero,
                        ),
                      ),
                    ),
                    // カスタマイズと個別化ボタン
                    Positioned(
                      bottom: 8,
                      left: 20,
                      child: Row(
                        children: [
                          _buildPillButton('カスタマイズ', const Color.fromARGB(255, 218, 160, 179)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ひとことセクション
                      Text(
                        'ひとこと',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade100,
                          ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: BoxBorder.all(
                            color: Colors.orange.shade100
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'あなたの投稿は元気いっぱい！ただ、ちょっとがんばりすぎサインも。ときには立ち止まってリフレッシュしよう。',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 1週間レポートセクション
                      Text(
                        '1週間レポート',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade100
                          ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: BoxBorder.all(
                            color: Colors.orange.shade100
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 200, // グラフの高さ
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false, // 縦線を非表示
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.orange.shade100, // 例えば薄いグレーの点線に
                                  strokeWidth: 1, // 線の太さ
                                  dashArray: [5, 5]
                                );
                              },
                              horizontalInterval: 1, // 横線の間隔
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) =>
                                      SizedBox(), // 下のラベルを非表示
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) =>
                                      SizedBox(), // 左のラベルを非表示
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                  color: const Color(0xff37434d), width: 0), // 枠線を非表示
                            ),
                            minX: 0,
                            maxX: 6,
                            minY: 0,
                            maxY: 3.5,
                            lineBarsData: [
                              LineChartBarData(
                                spots: weeklyReportData,
                                isCurved: false, // 滑らかな曲線にしない
                                barWidth: 2,
                                color: Colors.orange.shade200, // 線の色
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true, // 点を表示
                                  getDotPainter: (spot, percent, bar, index) {
                                    return FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.orange.shade200, // 点の色
                                      strokeWidth: 2,
                                      strokeColor: Colors.white, // 点の周りの色
                                    );
                                  },
                                ),
                                belowBarData: BarAreaData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ページインジケーター（3つの点）
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3, // ページの数
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0
                                  ? Colors.orange.shade200 // 現在のページ
                                  : Colors.orange.shade50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // カプセル型ボタンのヘルパーメソッド
  Widget _buildPillButton(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1), // 枠線
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}

// アプリのエントリーポイント
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProfileScreen(),
    );
  }
}
