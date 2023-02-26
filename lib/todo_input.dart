// class ToDoInput extends ConsumerStatefulWidget {
//   @Deprecated('use ToDoInputView')
//   const ToDoInput({Key? key}) : super(key: key);
//
//   /// このインスタンスを表示する静的メソッド
//   static Future<void> show(BuildContext context) {
//     return showModalBottomSheet(
//         context: context, builder: (context) => const ToDoInput());
//   }
//
//   @override
//   State<ToDoInput> createState() => _ToDoInputState();
// }
//
// class _ToDoInputState extends State<ToDoInput> {
//   // TextField の初期値や入力値を取得するために使う
//   final _textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         // キーボードが表示された分下から押し上げる
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         // 画面両端に余白を入れる
//         right: 10,
//         left: 10,
//       ),
//       child: Column(
//         // TextField の高さに合わせる
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             // 入力値の変更を外部インスタンスで制御できるようにする
//             controller: _textController,
//             // 画面表示時にフォーカスする
//             autofocus: true,
//             // キーボードで done(完了)したらこの画面を閉じる
//             onEditingComplete: () {
//               if (_textController.text.isNotEmpty) {
//                 // 入力値があればToDoを追加する
//                 DbHelper.instance.add(
//                   ToDo(title: _textController.text),
//                 );
//               }
//               Navigator.pop(context);
//             },
//             decoration: const InputDecoration(
//               // TextField の下線を消す
//               border: InputBorder.none,
//               // 未入力時に表示するテキスト
//               hintText: 'ToDoのタイトルを入力します',
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
