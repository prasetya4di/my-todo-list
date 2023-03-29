import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/finish_todo.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

class FinishTodoImpl implements FinishTodo {
  final TodoRepository _repository;

  FinishTodoImpl(this._repository);

  @override
  call(Todo todo) {
    todo.finishedDate = DateTime.now();

    _repository.update(todo);
  }
}
