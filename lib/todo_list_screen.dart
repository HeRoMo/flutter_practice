import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice/provider.dart';
import 'package:practice/todo_input_view.dart';

class ToDoListScreen extends HookConsumerWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ToDoListState に変更があるとリビルドされる
    final todos = ref.watch(todoListProvider);
    // ToDoListStateのメソッドを使えるようにする
    final todoNotifier = ref.watch(todoListProvider.notifier);

    // build が呼ばれてからToDoリストを読み込む
    useEffect(() {
      todoNotifier.find();
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        // ListTile から CheckboxListTile に変更する
        itemBuilder: (context, index) => CheckboxListTile(
            onChanged: (context) {
              todoNotifier.toggle(todos[index]);
            },
            value: todos[index].value.archived,
            title: GestureDetector(
              onTap: () {
                ToDoInputView.show(
                  context,
                  record: todos[index],
                );
              },
              child: Text(todos[index].value.title),
            )),
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ToDoInputView.show(context);
        },
      ),
    );
  }
}
