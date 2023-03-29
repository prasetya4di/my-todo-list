import 'package:my_todo_list/data/model/entity/todo.dart';

abstract class TodoDao {
  int insert(Todo todo);

  update(Todo todo);

  List<Todo> get();
}
