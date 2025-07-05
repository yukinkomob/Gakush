import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ガクッシュ！', // アプリのタイトル
      theme: ThemeData(
        primarySwatch: Colors.blue, // アプリのメインカラー
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(), // アプリの開始画面
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // 現在選択されているタブのインデックス
  late PageController _pageController; // PageViewを制御するためのコントローラ

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex); // 初期ページを設定
  }

  @override
  void dispose() {
    _pageController.dispose(); // コントローラを破棄し、リソースを解放
    super.dispose();
  }

  // ボトムナビゲーションバーのアイテムがタップされたときに呼び出されるメソッド
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // 現在のインデックスを更新
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300), // ページ切り替えのアニメーション時間
        curve: Curves.ease, // アニメーションのカーブ
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ガクッシュ！'), // ここにタイトルバーを追加
        centerTitle: true, // タイトルを中央に配置
      ),
      body: PageView(
        controller: _pageController,
        // ユーザーがスワイプでページを切り替えたときに、ボトムナビゲーションバーの選択状態も更新
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          // 各タブに対応する画面
          HomeScreen(),
          SearchScreen(),
          AccountScreen(),
          ChatScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 現在選択されているタブを設定
        onTap: _onTabTapped, // タブがタップされたときの処理
        selectedItemColor: Colors.blue, // 選択されたアイテムの色
        unselectedItemColor: Colors.grey, // 選択されていないアイテムの色
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radar), // レーダーチャート用のアイコン
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.blueAccent),
          SizedBox(height: 20),
          Text('Home Screen', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Welcome!', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text('Search Screen', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Find what you need.', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.deepOrange),
          SizedBox(height: 20),
          Text('Account Screen', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text('Manage your profile.', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FoodRadarChartScreen extends StatelessWidget {
  const FoodRadarChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('折れ線グラフ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth * 0.95,
          height: screenWidth * 0.95 * 0.65,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(1, 0),
                    FlSpot(2, 400),
                    FlSpot(3, 650),
                    FlSpot(4, 800),
                    FlSpot(5, 870),
                    FlSpot(6, 920),
                    FlSpot(7, 960),
                    FlSpot(8, 980),
                    FlSpot(9, 990),
                    FlSpot(10, 995),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                ),
              ],
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(
                  axisNameWidget: Text(
                    "労働の限界生産性",
                  ),
                  axisNameSize: 35.0,
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              maxY: 1000,
              minY: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController(); // メッセージ入力用コントローラ
  final List<String> _messages = []; // 送信されたメッセージを格納するリスト

  // メッセージ送信時に呼び出されるメソッド
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text); // メッセージをリストに追加
        _messageController.clear(); // 入力フィールドをクリア
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose(); // コントローラを破棄
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('シンプルなチャット'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // メッセージリスト表示部分
          Expanded(
            child: ListView.builder(
              reverse: true, // 最新のメッセージが下に来るようにリストを反転
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // リストは逆順なので、表示するメッセージは _messages.length - 1 - index
                final message = _messages[_messages.length - 1 - index];
                return Align(
                  // 仮に、インデックスが偶数なら自分、奇数なら相手のメッセージとして右寄せ/左寄せ
                  alignment: (index % 2 == 0) ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: (index % 2 == 0) ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: (index % 2 == 0) ? Colors.blue[900] : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // メッセージ入力部分
          const Divider(height: 1.0), // 区切り線
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(), // 入力フィールドと送信ボタン
          ),
        ],
      ),
    );
  }

  // テキスト入力フィールドと送信ボタンを構築するウィジェット
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            // メッセージ入力フィールド
            Flexible(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _sendMessage(), // エンターキーで送信
                decoration: const InputDecoration.collapsed(hintText: 'メッセージを入力...'),
              ),
            ),
            // 送信ボタン
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage, // ボタンタップで送信
              ),
            ),
          ],
        ),
      ),
    );
  }
}
