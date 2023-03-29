import 'package:my_todo_list/data/model/entity/todo.dart';

abstract class AddTodo {
  Todo call(Todo todo);
}
