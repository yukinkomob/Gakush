import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // レーダーチャート表示にFlChartを使用

class SelfAnalysisScreen extends StatefulWidget {
  @override
  _SelfAnalysisScreenState createState() => _SelfAnalysisScreenState();
}

class _SelfAnalysisScreenState extends State<SelfAnalysisScreen> {
  // 自己分析のダミーデータ（各特性のスコアを0-100で表現）
  final Map<String, int> _analysisScores = {
    '主体性': 85,
    '好奇心': 70,
    '活発性': 60,
    '柔軟性': 75,
    '戦略性': 50,
    '協調性': 90,
  };

  // 各特性の詳細説明（Jibundam風にポジティブな表現）
  final Map<String, String> _analysisDetails = {
    '主体性': '目標に向かってエネルギッシュに進み、やり遂げることに大きな喜びを感じるあなた。最後まで諦めない強い心が魅力です！',
    '好奇心': '新しい知識やスキルを学ぶことに喜びを感じ、常に成長を求める探求心の持ち主。あなたの知的好奇心は尽きません！',
    '活発性': '積極的に行動し、周りを巻き込みながら成果を出すのが得意なあなた。あなたのエネルギーは周囲を明るくします！',
    '柔軟性': 'あなたのしなやかな心は、どんな変化も前向きなチャンスに変えられます。その適応力が、あなたの可能性をどこまでも広げてくれます！',
    '戦略性': '複雑な状況から最適な道筋を見つけ出し、効率的に物事を進める論理的な思考力を持つあなた。計画性があなたの強みです！',
    '協調性': '他者の感情や気持ちを敏感に察知し、寄り添うことができる優しい心の持ち主。あなたの温かさは周りを癒します！',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('あなたの隠れた才能！', '自己分析結果'),
              SizedBox(height: 20),

              // レーダーチャートで全体像を視覚化
              _buildInsightCard(
                title: 'あなたの特性マップ',
                content: Container(
                  height: 250,
                  padding: EdgeInsets.all(16),
                  child: _buildRadarChart(),
                ),
                icon: Icons.auto_graph,
                iconColor: Colors.deepPurple.shade400,
              ),
              SizedBox(height: 20),

              // 各特性の詳細分析
              _buildSectionHeader('強みをもっと知ろう！', '各特性の詳細'),
              SizedBox(height: 20),
              ..._analysisScores.keys.map((trait) {
                return _buildAnalysisTraitCard(
                  trait: trait,
                  score: _analysisScores[trait]!,
                  description: _analysisDetails[trait]!,
                );
              }).toList(),
              SizedBox(height: 20),

              // 全体の総評
              _buildSectionHeader('総評', 'あなただけのスペシャルメッセージ'),
              SizedBox(height: 20),
              _buildInsightCard(
                title: 'あなたという素晴らしい存在へ',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'あなたの分析結果からは、特に「主体性」と「協調性」が際立っていますね！',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffff914d),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '目標に向かって粘り強く努力し、その過程で周りの人々への温かい配慮を忘れない。そんな素敵なあなたが、もっと自分らしく輝くためのヒントは「学習欲」をさらに高めることかもしれません。新しい知識を得ることで、あなたの強みはさらに磨かれるでしょう！',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'これからもJibundamと一緒に、あなたの可能性をどんどん広げていきましょう！',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  ],
                ),
                icon: Icons.emoji_events_outlined,
                iconColor: Colors.amber.shade700,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // セクションヘッダー
  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xffff914d),
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // 分析結果を表示するカード（_InsightCardは振り返り画面から流用し、汎用的に使用）
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

  // 各特性の分析結果カード
  Widget _buildAnalysisTraitCard({
    required String trait,
    required int score,
    required String description,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9), // 少し透明感のある白
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, size: 24, color: Colors.orange.shade400),
                SizedBox(width: 8),
                Text(
                  trait,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffff914d),
                  ),
                ),
                Spacer(),
                // スコアの表示（可愛らしいバッジ風）
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Text(
                    '$score%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  // レーダーチャートのウィジェット
  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            // 各特性のスコアを0-1で正規化してプロット
            dataEntries: _analysisScores.values.map((score) => score / 100.0).map((score) => RadarEntry(value: score)).toList(),
            // dataEntries: [4.0, 4.5, 4.0, 4.2, 5.0, 4.3].map((value) {
            //   return RadarEntry(value: value);
            // }).toList()
            borderColor: Colors.orangeAccent.withOpacity(0.7),
            fillColor: Colors.orangeAccent.withOpacity(0.3),
            borderWidth: 2,
          ),
        ],
        // チャートの軸の設定
        radarBackgroundColor: Colors.transparent, // 背景色を透明に
        radarBorderData: const BorderSide(color: Colors.orange, width: 1.5), // レーダーの枠線
        gridBorderData: BorderSide(color: Colors.orange.shade200, width: 1), // グリッド線

        getTitle: (index, angle) {
          final titles = _analysisScores.keys.toList();
          return RadarChartTitle(
            text: titles[index],
            angle: angle,
            // textStyle: TextStyle(
            //   color: Color(0xffff914d),
            //   fontWeight: FontWeight.bold,
            //   fontSize: 13,
            // ),
          );
        },
        tickBorderData: BorderSide(color: Colors.orange.shade200, width: 1), // 目盛りの線
        tickCount: 5, // 目盛りの数 (0.2, 0.4, 0.6, 0.8, 1.0)
        ticksTextStyle: TextStyle(color: Colors.grey.shade600, fontSize: 10), // 目盛りのテキストスタイル
        // スコアの範囲を設定
        // max: 1.0, // 0-1で正規化しているので最大値は1.0
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // アニメーション
    );
  }
}
