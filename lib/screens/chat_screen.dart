import 'package:flutter/material.dart';

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
