import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice/database.dart';
import 'package:practice/todo.dart';
import 'package:practice/todo_list_state.dart';

class MockDbHelper extends Mock implements DbHelper {}

void main() {
  final dbHelper = MockDbHelper();

  when(() => dbHelper.add(
        ToDo(title: 'test'),
      )).thenAnswer((_) async => ToDoRecord(
        1,
        ToDo(title: 'test'),
      ));

  test('test todo state', () async {
    final state = ToDoListState(const [], dbHelper);
    await state.add(ToDo(title: 'test'));

    // protected メンバーだが、値を確認するために使う
    expect(state.state.first.key, 1);
    expect(state.state.first.value.title, 'test');
  });
}
