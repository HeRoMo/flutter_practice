// 初期値はなく使うときまでにオーバーライドする
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice/database.dart';
import 'package:practice/todo.dart';
import 'package:practice/todo_list_state.dart';

final databaseProvider = Provider<DbHelper>((_) => throw UnimplementedError());

final todoListProvider = StateNotifierProvider<ToDoListState, List<ToDoRecord>>(
  (ref) => ToDoListState(
    [],
    ref.watch(databaseProvider),
  ),
);
