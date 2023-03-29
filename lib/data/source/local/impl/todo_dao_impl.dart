import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/data/source/local/todo_dao.dart';
import 'package:my_todo_list/objectbox.g.dart';

class TodoDaoImpl implements TodoDao {
  final Box<Todo> _box;

  TodoDaoImpl(this._box);

  @override
  List<Todo> get() => _box.getAll();

  @override
  insert(Todo todo) {
    _box.put(todo, mode: PutMode.insert);
  }

  @override
  update(Todo todo) {
    _box.put(todo, mode: PutMode.update);
  }
}
