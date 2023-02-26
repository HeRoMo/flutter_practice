import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice/provider.dart';
import 'package:practice/todo.dart';

class ToDoInputView extends HookConsumerWidget {
  const ToDoInputView({Key? key, this.record}) : super(key: key);

  final ToDoRecord? record;

  /// ToDoInputView を表示する静的メソッド
  static Future<void> show(
    BuildContext context, {
    ToDoRecord? record,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ToDoInputView(record: record),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: record?.value.title,
    );

    final todoListNotifier = ref.watch(todoListProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        // キーボードが表示された分、下から押し上げる
        bottom: MediaQuery.of(context).viewInsets.bottom,
        // 画面両端に余白を設ける
        right: 10,
        left: 10,
      ),
      child: Column(
        // TextField の高さに合わせる
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            // 入力値の変更を外部インスタンスで制御できるようにする
            controller: controller,
            // 画面表示時にフォーカスする
            autofocus: true,
            onEditingComplete: () async {
              if (controller.text.isEmpty) {
                return;
              }

              if (record == null) {
                await todoListNotifier.add(
                  ToDo(title: controller.text),
                );
              } else {
                // ToDoのTitleを更新する
                final updatedToDo = record!.value.copyWith(
                  title: controller.text,
                );

                // 新しいToDoRecordとToDoで更新する
                await todoListNotifier.update(
                  record!.copyWith(
                    value: updatedToDo,
                  ),
                );
              }
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
                // TextFieldの下線を消す
                border: InputBorder.none,
                hintText: 'ToDoのタイトルを入力する'),
          )
        ],
      ),
    );
  }
}
