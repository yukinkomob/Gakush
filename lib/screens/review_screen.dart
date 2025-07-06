import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // 進捗率のグラフ表示にFlChartを使用

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 週、月、総評の3タブ
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade100], // 淡いピンクのグラデーション
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildWeeklyReview(),
            _buildMonthlyReview(),
            _buildOverallReview(),
          ],
        ),
      ),
    );
  }

  // 週の振り返りタブの内容
  Widget _buildWeeklyReview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewHeader('今週の振り返り', '2024年7月1日〜7月7日'),
          _buildInsightCard(
            title: '記録達成率',
            content: Column(
              children: [
                SizedBox(height: 30),
                _buildProgressPieChart(0.75), // 例: 75%
                SizedBox(height: 40),
                Text('目標を75%達成しました！素晴らしい一週間でしたね！',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Color(0xffff914d), fontWeight: FontWeight.bold)),
              ],
            ),
            icon: Icons.check_circle_outline,
            iconColor: Colors.green.shade400,
          ),
          _buildInsightCard(
            title: '今週のポジティブポイント',
            content: Text(
              '「新しい習慣」に積極的に取り組めました！特に朝活が定着し始めています。この調子で頑張りましょう！',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            icon: Icons.lightbulb_outline,
            iconColor: Colors.amber.shade400,
          ),
          _buildInsightCard(
            title: '改善点と来週のヒント',
            content: Text(
              '「休憩の取り方」を意識すると、集中力を長く保てそうです。短い休憩を挟んでリフレッシュしてみましょう！',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            icon: Icons.tune,
            iconColor: Colors.blue.shade400,
          ),
          SizedBox(height: 20),
          _buildCuteIllustration('もっと自分を成長させよう！'),
        ],
      ),
    );
  }

  // 月の振り返りタブの内容
  Widget _buildMonthlyReview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewHeader('今月の振り返り', '2024年7月'),
          _buildInsightCard(
            title: '記録継続率',
            content: Column(
              children: [
                _buildProgressPieChart(0.88), // 例: 88%
                SizedBox(height: 10),
                Text('記録継続率88%！着実に習慣化できていますね！',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Color(0xffff914d), fontWeight: FontWeight.bold)),
              ],
            ),
            icon: Icons.calendar_today_outlined,
            iconColor: Colors.purple.shade400,
          ),
          _buildInsightCard(
            title: '今月のハイライト',
            content: Text(
              '目標としていた「健康的な食生活」がかなり意識できるようになりました。自炊の回数も増え、体調が良い日が増えました！',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            icon: Icons.local_florist_outlined,
            iconColor: Colors.green.shade400,
          ),
          _buildInsightCard(
            title: '来月のチャレンジ',
            content: Text(
              '「新しいスキル習得」に焦点を当ててみましょう。オンライン講座を活用するのも良いですね！',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            icon: Icons.next_plan_outlined,
            iconColor: Colors.orange.shade400,
          ),
          SizedBox(height: 20),
          _buildCuteIllustration('毎日の積み重ねが未来を作る！'),
        ],
      ),
    );
  }

  // 総評タブの内容
  Widget _buildOverallReview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewHeader('あなたの成長の軌跡', '全体総評'),
          _buildInsightCard(
            title: 'Jibundamとの歩み',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jibundamを使い始めて${DateTime.now().difference(DateTime(2024, 1, 1)).inDays}日が経ちました！', // ダミーの日数
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xffff914d)),
                ),
                SizedBox(height: 8),
                Text(
                  'これまでの記録から、あなたは「継続力」と「自己改善意識」が特に高いことがわかります。素晴らしい才能ですね！',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                SizedBox(height: 8),
                Text(
                  '特に、初期の目標だった「ストレス管理」が大きく改善されており、ポジティブな日が増えています。',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
            icon: Icons.favorite_border,
            iconColor: Colors.red.shade400,
          ),
          _buildInsightCard(
            title: '次なるステップへ',
            content: Text(
              'これまでの経験を活かして、さらに大きな目標に挑戦してみましょう！Jibundamはあなたの成長を全力でサポートします！',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            icon: Icons.rocket_launch_outlined,
            iconColor: Colors.deepOrange.shade400,
          ),
          SizedBox(height: 20),
          _buildCuteIllustration('これからも自分らしく輝こう！'),
        ],
      ),
    );
  }

  // 振り返りセクションのヘッダー
  Widget _buildReviewHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xffff914d),
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // 分析内容を示すカード
  Widget _buildInsightCard({
    required String title,
    required Widget content,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.95), // 少し透明感のある白
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: iconColor),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  // 円グラフ（進捗率）のウィジェット
  Widget _buildProgressPieChart(double percentage) {
    return Container(
      height: 150,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.orangeAccent,
              value: percentage * 100,
              title: '${(percentage * 100).toInt()}%',
              radius: 60,
              titleStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              color: Colors.orange.shade100,
              value: (1 - percentage) * 100,
              title: '',
              radius: 60,
            ),
          ],
          sectionsSpace: 0,
          centerSpaceRadius: 40, // 中央の空白
        ),
      ),
    );
  }

  // 可愛らしいイラスト表示
  Widget _buildCuteIllustration(String message) {
    return Center(
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffff914d),
            ),
          ),
        ],
      ),
    );
  }
}
