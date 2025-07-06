import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // 検索結果を格納するリスト
  List<String> _recentSearches = [ // 過去の検索履歴（ダミーデータ）
    '今日の目標達成',
    '運動記録',
    '読書感想',
    '新しい趣味',
    '気分グラフ',
  ];

  // 特徴的なキーワード（チップス）の例
  final List<String> _popularKeywords = [
    '目標', '達成', '感情', '学習', '健康', '人間関係', '仕事', '趣味', '日記', '振り返り'
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // 検索バーに入力があるたびに検索候補を更新するなどのロジック
    // 今回はシンプルに、検索結果をダミーで更新
    _performSearch(_searchController.text);
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = []; // 検索クエリが空なら結果も空に
      } else {
        // ここで実際の検索ロジックを実装
        // ダミーデータとして、クエリを含む過去の記録をフィルタリング
        _searchResults = _recentSearches
            .where((record) => record.contains(query.toLowerCase()))
            .toList();
        // もしヒットしなくても何か表示するためにダミーを追加
        if (_searchResults.isEmpty) {
          _searchResults = ['"${query}" の記録は見つかりませんでした...'];
        }
      }
    });
  }

  void _addRecentSearch(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query); // 最新のものを先頭に追加
        if (_recentSearches.length > 5) { // 例: 5件まで保持
          _recentSearches.removeLast();
        }
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.pink.shade100], // 淡いピンクのグラデーション
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // 検索バー
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'キーワードを入力...',
                  hintStyle: TextStyle(color: Colors.pink.shade300.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, color: Colors.pink),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none, // 枠線をなくす
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9), // 背景を白く
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                onSubmitted: (query) {
                  _addRecentSearch(query); // 検索履歴に追加
                  _performSearch(query); // 検索を実行
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 特徴的なキーワード（チップス）
                      _buildSectionTitle('人気のキーワード'),
                      Wrap(
                        spacing: 8.0, // チップ間の水平方向のスペース
                        runSpacing: 8.0, // チップ間の垂直方向のスペース
                        children: _popularKeywords.map((keyword) {
                          return ActionChip(
                            label: Text(keyword, style: TextStyle(color: Colors.pink.shade700)),
                            avatar: Icon(Icons.star, size: 18, color: Colors.amber), // 可愛らしい星アイコン
                            onPressed: () {
                              _searchController.text = keyword;
                              _addRecentSearch(keyword);
                              _performSearch(keyword);
                            },
                            backgroundColor: Colors.pink.shade50.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.pink.shade200, width: 1),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24),

                      // 過去の記録（検索履歴）
                      _buildSectionTitle('最近の検索'),
                      _recentSearches.isEmpty
                          ? Text('まだ検索履歴がありません。', style: TextStyle(color: Colors.grey.shade600))
                          : Column(
                              children: _recentSearches.map((record) {
                                return ListTile(
                                  leading: Icon(Icons.history, color: Colors.pink.shade300),
                                  title: Text(record, style: TextStyle(color: Colors.grey.shade800)),
                                  trailing: IconButton(
                                    icon: Icon(Icons.clear, size: 18, color: Colors.grey.shade500),
                                    onPressed: () {
                                      setState(() {
                                        _recentSearches.remove(record);
                                      });
                                    },
                                  ),
                                  onTap: () {
                                    _searchController.text = record;
                                    _performSearch(record);
                                  },
                                );
                              }).toList(),
                            ),
                      SizedBox(height: 24),

                      // 検索結果
                      if (_searchController.text.isNotEmpty) // 検索クエリがある場合のみ表示
                        _buildSectionTitle('検索結果'),
                      if (_searchController.text.isNotEmpty)
                        _searchResults.isEmpty
                            ? Text(
                                '一致する記録が見つかりませんでした。',
                                style: TextStyle(color: Colors.grey.shade600),
                              )
                            : ListView.builder(
                                shrinkWrap: true, // ListViewをColumn内で使用するために必要
                                physics: NeverScrollableScrollPhysics(), // ListView自体のスクロールを無効化
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 6.0),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: ListTile(
                                      leading: Icon(Icons.event_note, color: Colors.pink),
                                      title: Text(_searchResults[index], style: TextStyle(fontWeight: FontWeight.w500)),
                                      subtitle: Text('2024年7月5日', style: TextStyle(color: Colors.grey.shade600)), // ダミーの日付
                                      onTap: () {
                                        // 検索結果の項目をタップした時の処理
                                        print('選択された検索結果: ${_searchResults[index]}');
                                      },
                                    ),
                                  );
                                },
                              ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // セクションタイトルを生成するヘルパー関数（設定画面から流用）
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0), // 左側のパディングを調整
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade700,
        ),
      ),
    );
  }
}
