import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用パッケージ (pubspec.yaml に追加が必要です)

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  // ダミーデータ
  final List<Map<String, String>> _recentRecords = [
    {
      'date': '2025/06/30',
      'title': 'インターンシップ初日',
      'content': '緊張したけど、先輩に丁寧に教えてもらえた。思ったより開発スピードが速い...',
    },
    {
      'date': '2025/06/28',
      'title': '読書記録「FACTFULNESS」',
      'content': '物事をデータで捉える重要性を改めて認識。自分の思い込みに気づかされた。',
    },
    {
      'date': '2025/06/25',
      'title': 'ゼミ発表準備完了',
      'content': '資料作成に徹夜。チームメンバーとの連携がうまくいったのが良かった点。',
    },
  ];

  // 記録した日（ダミーデータ） - 日付のみ
  // 実際はサーバーから取得し、Set<int>などで効率的に管理します
  final Set<int> _recordedDaysInMonth = {1, 5, 8, 10, 15, 20, 25, 28, 30}; // 今月記録した日

  final List<String> _unansweredQuestions = [
    '最近、最も嬉しかった出来事は何ですか？',
    'あなたの強みを活かせた経験について教えてください。',
    '将来、どのような分野で活躍したいですか？具体的に教えてください。',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- 直近3件までの登録記録 ---
            Text(
              '直近の活動記録',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_recentRecords.isEmpty)
              const Center(child: Text('まだ記録がありません。', style: TextStyle(color: Colors.grey)))
            else
              Column(
                children: _recentRecords.map((record) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record['date']!,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            record['title']!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            record['content']!,
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // --- 今月のカレンダーの表示 ---
            Text(
              '今月の活動カレンダー',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMonthlyCalendar(context),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // --- 未回答の質問 ---
            Text(
              '未回答の質問',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_unansweredQuestions.isEmpty)
              const Center(child: Text('未回答の質問はありません！', style: TextStyle(color: Colors.green)))
            else
              Column(
                children: _unansweredQuestions.map((question) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Colors.yellow[50], // 未回答質問の背景色を少し変える
                    child: ListTile(
                      title: Text(
                        question,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('質問に回答します: "$question"')));
                        // 質問回答画面への遷移ロジック
                      },
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  // 今月のカレンダーを生成するヘルパーウィジェット
  Widget _buildMonthlyCalendar(BuildContext context) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day; // 今月の日数
    final weekdayOfFirstDay = firstDayOfMonth.weekday; // 月初めの曜日 (月曜=1, 日曜=7)

    // 曜日の表示
    final List<String> weekdays = ['月', '火', '水', '木', '金', '土', '日'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // カレンダーヘッダー (年と月)
            Text(
              DateFormat('yyyy年MM月').format(now),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // 曜日表示
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // スクロールさせない
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0, // 正方形のセル
              ),
              itemCount: weekdays.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    weekdays[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (index == 5 || index == 6) ? Colors.red : Colors.black87, // 土日を赤く
                    ),
                  ),
                );
              },
            ),
            // 日付表示
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // スクロールさせない
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0, // 正方形のセル
              ),
              itemCount: daysInMonth + (weekdayOfFirstDay == 7 ? 0 : weekdayOfFirstDay), // 前月の空白も考慮
              itemBuilder: (context, index) {
                if (index < (weekdayOfFirstDay == 7 ? 0 : weekdayOfFirstDay)) {
                  // 前月の空白セル
                  return Container();
                }
                final day = index - (weekdayOfFirstDay == 7 ? 0 : weekdayOfFirstDay) + 1;
                final isRecorded = _recordedDaysInMonth.contains(day);
                final isToday = day == now.day && now.month == firstDayOfMonth.month && now.year == firstDayOfMonth.year;

                return Container(
                  decoration: BoxDecoration(
                    color: isToday ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.blue : Colors.black87,
                          ),
                        ),
                        if (isRecorded)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 12,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
