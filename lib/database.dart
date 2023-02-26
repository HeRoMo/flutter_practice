import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice/todo.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbHelper {
  // プライベートな名前付きコンストラクタ
  DbHelper._();

  /// このクラスの同一のインスタンスを返す
  static DbHelper get instance => _instance;

  // 初回の呼び出しでインスタンスを生成
  static final DbHelper _instance = DbHelper._();

  // プライベートな Database インスタンス
  late final Database _database;

  // 実際にデータを保存するためのインスタンス
  late final StoreRef<int, Map<String, dynamic>> _store;

  Future<void> initialize() async {
    // データベースの保存先を取得する
    final appDir = await getApplicationDocumentsDirectory();

    // データベースを開く
    _database = await databaseFactoryIo.openDatabase(
      join(appDir.path, 'todo.db'),
    );

    // データを保存する療育を確保する
    _store = intMapStoreFactory.store('todo');
  }

  Future<List<ToDoRecord>> find() async {
    final result = await _store.find(_database,
        finder: Finder(
          sortOrders: [SortOrder(Field.key, false)],
        ));

    return result
        .map((e) => ToDoRecord(e.key, ToDo.fromJson(e.value)))
        .toList();
  }

  Future<ToDoRecord> add(ToDo todo) async {
    final key = await _store.add(_database, todo.toJson());
    return ToDoRecord(key, todo);
  }

  Future<void> update(int key, ToDo todo) async {
    _store.record(key).put(_database, todo.toJson());
  }
}
