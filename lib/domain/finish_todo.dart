import 'package:my_todo_list/data/model/entity/todo.dart';

abstract class FinishTodo {
  call(Todo todo);
}
