import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SimpleSettingsScreenState createState() => _SimpleSettingsScreenState();
}

class _SimpleSettingsScreenState extends State<SettingsScreen> {
  // 設定項目の状態を管理する変数
  bool _isDarkMode = false;
  String _selectedAvatar = 'avatar_default';
  String _selectedBackground = 'background_pink_gradient';
  String _selectedFont = 'JibundamFont';

  // アバターの選択肢（プレースホルダー）
  final List<Map<String, String>> _avatars = [
    {'name': 'デフォルト', 'image': 'assets/avatar_default.png'},
    {'name': 'カジュアル', 'image': 'assets/avatar_casual.png'},
    {'name': 'フェミニン', 'image': 'assets/avatar_feminine.png'},
  ];

  // 背景画像の選択肢（プレースホルダー）
  final List<Map<String, String>> _backgrounds = [
    {'name': 'ピンクグラデ', 'image': 'assets/background_pink_gradient.png'},
    {'name': '水玉模様', 'image': 'assets/background_polkadot.png'},
    {'name': '雲柄', 'image': 'assets/background_clouds.png'},
  ];

  // フォントの選択肢（プレースホルダー）
  final List<String> _fonts = ['JibundamFont', 'NotoSansJP', 'HiraMaruProN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.pink.shade100], // 淡いピンクのグラデーション
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: <Widget>[
            _buildSettingSection(
              title: '表示設定',
              children: [
                _buildSimpleSettingTile(
                  title: 'テーマ変更',
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _isDarkMode = value;
                        // テーマ切り替えロジック
                      });
                    },
                    activeColor: Colors.pinkAccent,
                  ),
                ),
                // _buildSimpleSettingTile(
                //   title: 'アバター着せ替え',
                //   trailing: DropdownButton<String>(
                //     value: _selectedAvatar,
                //     icon: const Icon(Icons.arrow_drop_down, color: Colors.pink),
                //     underline: Container(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _selectedAvatar = newValue!;
                //         // アバター変更ロジック
                //       });
                //     },
                //     items: _avatars.map<DropdownMenuItem<String>>((avatar) {
                //       return DropdownMenuItem<String>(
                //         value: avatar['image'],
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               backgroundImage: AssetImage(avatar['image']!),
                //               radius: 15,
                //             ),
                //             SizedBox(width: 8),
                //             Text(avatar['name']!),
                //           ],
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),
                // _buildSimpleSettingTile(
                //   title: '背景画像',
                //   trailing: DropdownButton<String>(
                //     value: _selectedBackground,
                //     icon: const Icon(Icons.arrow_drop_down, color: Colors.pink),
                //     underline: Container(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _selectedBackground = newValue!;
                //         // 背景画像変更ロジック
                //       });
                //     },
                //     items: _backgrounds.map<DropdownMenuItem<String>>((bg) {
                //       return DropdownMenuItem<String>(
                //         value: bg['image'],
                //         child: Text(bg['name']!),
                //       );
                //     }).toList(),
                //   ),
                // ),
                // _buildSimpleSettingTile(
                //   title: 'フォント',
                //   trailing: DropdownButton<String>(
                //     value: _selectedFont,
                //     icon: const Icon(Icons.arrow_drop_down, color: Colors.pink),
                //     underline: Container(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _selectedFont = newValue!;
                //         // フォント変更ロジック
                //       });
                //     },
                //     items: _fonts.map<DropdownMenuItem<String>>((font) {
                //       return DropdownMenuItem<String>(
                //         value: font,
                //         child: Text(font),
                //       );
                //     }).toList(),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 30), // セクション間のスペースを広げる
            _buildSettingSection(
              title: 'アカウント',
              children: [
                _buildSimpleSettingTile(
                  title: 'プロフィール編集',
                  onTap: () => print('プロフィール編集へ'),
                ),
                _buildSimpleSettingTile(
                  title: 'パスワード変更',
                  onTap: () => print('パスワード変更へ'),
                ),
                _buildSimpleSettingTile(
                  title: '通知設定',
                  onTap: () => print('通知設定へ'),
                ),
              ],
            ),
            SizedBox(height: 30),
            _buildSettingSection(
              title: 'その他',
              children: [
                _buildSimpleSettingTile(
                  title: '利用規約',
                  onTap: () => print('利用規約表示'),
                ),
                _buildSimpleSettingTile(
                  title: 'プライバシーポリシー',
                  onTap: () => print('プライバシーポリシー表示'),
                ),
                _buildSimpleSettingTile(
                  title: 'お問い合わせ',
                  onTap: () => print('お問い合わせへ'),
                ),
                _buildSimpleSettingTile(
                  title: 'アプリバージョン',
                  trailing: Text('1.0.0', style: TextStyle(color: Colors.grey.shade600)),
                  onTap: null, // タップ不可
                ),
                _buildSimpleSettingTile(
                  title: 'ログアウト',
                  textColor: Colors.redAccent,
                  onTap: () => _showLogoutConfirmationDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // シンプルな設定項目ウィジェット
  Widget _buildSimpleSettingTile({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? Colors.grey.shade800,
              ),
            ),
            trailing ?? Icon(Icons.chevron_right, color: Colors.pink.shade300),
          ],
        ),
      ),
    );
  }

  // 設定セクションのグループ化
  Widget _buildSettingSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8), // 半透明の白で柔らかさを出す
            borderRadius: BorderRadius.circular(15), // 角丸
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade100.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index < children.length - 1)
                    Divider(height: 1, color: Colors.pink.shade100), // 区切り線
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // ログアウト確認ダイアログ
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('ログアウト', style: TextStyle(color: Colors.pink.shade700)),
          content: Text('本当にログアウトしますか？'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル', style: TextStyle(color: Colors.grey.shade600)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('ログアウト', style: TextStyle(color: Colors.red)),
              onPressed: () {
                print('ログアウト実行！');
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
