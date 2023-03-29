import 'package:get_it/get_it.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/data/source/local/impl/todo_dao_impl.dart';
import 'package:my_todo_list/data/source/local/objectbox.dart';
import 'package:my_todo_list/data/source/local/todo_dao.dart';
import 'package:my_todo_list/domain/add_todo.dart';
import 'package:my_todo_list/domain/finish_todo.dart';
import 'package:my_todo_list/domain/get_todo.dart';
import 'package:my_todo_list/domain/impl/add_todo_impl.dart';
import 'package:my_todo_list/domain/impl/finish_todo_impl.dart';
import 'package:my_todo_list/domain/impl/get_todo_impl.dart';
import 'package:my_todo_list/objectbox.g.dart';
import 'package:my_todo_list/repository/impl/todo_repository_impl.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

final di = GetIt.I;

Future<void> setupDI() async {
  // Object box
  final objectBox = await ObjectBox.create();
  di.registerSingleton<Box<Todo>>(objectBox.store.box<Todo>());

  // Dao
  di.registerSingleton<TodoDao>(TodoDaoImpl(di.get()));

  // Repository
  di.registerSingleton<TodoRepository>(TodoRepositoryImpl(di.get()));

  // Use Case
  di.registerSingleton<AddTodo>(AddTodoImpl(di.get()));
  di.registerSingleton<FinishTodo>(FinishTodoImpl(di.get()));
  di.registerSingleton<GetTodo>(GetTodoImpl(di.get()));
}
