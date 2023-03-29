import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:random_string/random_string.dart';

Todo createTodo() => Todo(randomString(5), DateTime.now());

List<Todo> createListTodo() => [createTodo(), createTodo(), createTodo()];
