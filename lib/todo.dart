class ToDo {
  ToDo({
    required this.title,
    this.archived = false,
  });

  // ToDoのタイトル
  String title;
  // ToDoの完了状態
  bool archived;
}
