import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Japanese weekdays
    final List<String> weekdays = ['日', '月', '火', '水', '木', '金', '土'];
    // Dates for July 2025, including trailing/leading days
    final List<int> days = [
      29, 30, 1, 2, 3, 4, 5,
      6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19,
      20, 21, 22, 23, 24, 25, 26,
      27, 28, 29, 30, 31, 1, 2,
      3, 4, 5, 6, 7, 8, 9,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png', // あなたのアプリのアイコン画像のパスを指定
              // height: 30, // 画像の高さ（適宜調整）
              width: 70,  // 画像の幅（適宜調整）
              // fit: BoxFit.contain, // 必要に応じてフィットさせる
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.grey[700]),
                  onPressed: () {},
                ),
                Text(
                  '2025年7月',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.grey[700]),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(width: 70)
          ],
        ),
      ),
      body: Column(
        children: [
          // Weekday headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekdays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: day == '日' ? Colors.red : Colors.black, // Sunday in red
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(color: Colors.grey[300]),
          // Calendar grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final int day = days[index];
                bool isCurrentMonth = (index >= 2 && index <= 32); // Adjust based on actual 1st and last day of July 2025
                bool isSelectedDay = day == 6 && isCurrentMonth; // July 6th is selected

                return Container(
                  decoration: isSelectedDay
                      ? BoxDecoration(
                          color: Colors.pink[100],
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color: isCurrentMonth
                            ? (index % 7 == 0 ? Colors.red : Colors.black) // Sunday in red for current month
                            : Colors.grey, // Previous/next month days in grey
                        fontWeight: isSelectedDay ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message and button area
          Container(
            height: 400, // Adjust height as needed
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.pink[50]!, // Light pink
                  Colors.pink[100]!, // Slightly darker pink
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 40, // Adjust position
                  child: CustomPaint(
                    painter: SpeechBubblePainter(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Text(
                        '今日は「Startup Weekend 松本 2nd」に参加しましたね。\n写真と感想を記録しませんか？',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100, // Adjust position
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.red[400]),
                    label: Text(
                      '記録・予定',
                      style: TextStyle(color: Colors.red[400], fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the speech bubble
class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Body of the bubble
    final bubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height - 20), // Adjust height for the tail
      Radius.circular(15),
    );
    path.addRRect(bubbleRect);

    // Tail of the bubble (pointing downwards)
    path.moveTo(size.width * 0.2 - 10, size.height - 20); // Left point of tail
    path.lineTo(size.width * 0, size.height); // Tip of the tail
    path.lineTo(size.width * 0.5 + 30, size.height - 20); // Right point of tail
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
