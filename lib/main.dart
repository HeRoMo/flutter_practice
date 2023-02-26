import 'package:flutter/material.dart';
import 'package:practice/database.dart';
import 'package:practice/todo.dart';

Future<void> main() async {
  // runApp の前に path_provider が使えるように呼び出す
  WidgetsFlutterBinding.ensureInitialized();

  // データベースを開く
  await DbHelper.instance.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ToDoRecord>>(
      // Futureを返すメソッドや関数を指定する
      future: DbHelper.instance.find(),
      initialData: const [],
      builder: (context, snapshot) {
        // 非同期処理が終わっていない場合に待機状態わかる Widget を表示する
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        // データの準備ができたら todos に展開する
        // nullable なので !
        // nullable なので !で解除する
        final todos = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('ToDo'),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              final todo = todos[index].value;

              return CheckboxListTile(
                onChanged: (checked) async {
                  final key = todos[index].key;
                  // 完了状態を反転させる
                  final update = todo.copyWith(
                    archived: !todo.archived,
                  );
                  await DbHelper.instance.update(key, update);
                  setState(() {});
                },
                value: todos[index].value.archived,
                title: Text(todo.title),
              );
            },
            itemCount: todos.length,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // ToDo を追加する
              await DbHelper.instance
                  .add(ToDo(title: 'Todo ${todos.length + 1}'));
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
