import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/data/source/local/todo_dao.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDao _dao;

  TodoRepositoryImpl(this._dao);

  @override
  List<Todo> get() => _dao.get();

  @override
  insert(Todo todo) {
    _dao.insert(todo);
  }

  @override
  update(Todo todo) {
    _dao.update(todo);
  }
}
