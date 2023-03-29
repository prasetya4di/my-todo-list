import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/add_todo.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

class AddTodoImpl implements AddTodo {
  final TodoRepository _repository;

  AddTodoImpl(this._repository);

  @override
  Todo call(Todo todo) {
    int id = _repository.insert(todo);
    todo.obxId = id;

    return todo;
  }
}
