import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/get_todo.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

class GetTodoImpl implements GetTodo {
  final TodoRepository _repository;

  GetTodoImpl(this._repository);

  @override
  List<Todo> call() => _repository.get();
}
