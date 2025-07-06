import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import './screens/chat_screen.dart';
import './screens/student_home_screen.dart';
import './screens/profile_screen.dart';
import './screens/settings_screen.dart';
import './screens/search_screen.dart';

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
      body: PageView(
        controller: _pageController,
        // ユーザーがスワイプでページを切り替えたときに、ボトムナビゲーションバーの選択状態も更新
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          // 各タブに対応する画面
          SearchScreen(),
          SettingsScreen(),
          ProfileScreen(),
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
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_retouching_natural),
            label: 'プロフィール',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_return),
            label: '振り返り',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics), // レーダーチャート用のアイコン
            label: '自己分析',
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
