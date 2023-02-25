import 'package:flutter/material.dart';
import 'package:practice/todo.dart';

void main() {
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
  // 仮のデータスタブ
  final todos = List.generate(
    10,
    (index) => ToDo(title: 'Todo ${index + 1}'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CheckboxListTile(
          onChanged: (checked) {
            // 完了状態を反転させる
            setState(() {
              final original = todos[index];
              todos[index] = original.copyWith(
                archived: !original.archived,
              );
            });
          },
          value: todos[index].archived,
          title: Text(todos[index].title),
        ),
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            todos.add(ToDo(title: 'Todo ${todos.length + 1}'));
          });
        },
      ),
    );
  }
}
