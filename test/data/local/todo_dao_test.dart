import 'package:flutter_test/flutter_test.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/data/source/local/impl/todo_dao_impl.dart';
import 'package:my_todo_list/data/source/local/todo_dao.dart';
import 'package:my_todo_list/objectbox.g.dart';
import 'package:random_string/random_string.dart';

import '../../util/dummy_builder.dart';
import 'objectbox.dart';

void main() {
  late ObjectBoxTest objectBoxTest;
  late Box<Todo> todoBox;
  late TodoDao todoDao;

  setUp(() async {
    objectBoxTest = await ObjectBoxTest.create();
    todoBox = objectBoxTest.store.box();
    todoDao = TodoDaoImpl(todoBox);
  });

  tearDown(() {
    todoBox.removeAll();
    objectBoxTest.delete();
  });

  group("Test insert todo", () {
    Todo todo = createTodo();

    test("Insert todo success", () {
      int newId = todoDao.insert(todo);
      Todo? insertedTodo = todoBox.get(newId);
      expect(insertedTodo?.obxId, newId);
    });

    test("Insert todo duplicate id should throw error", () {
      expect(() => todoDao.insert(todo),
          throwsA(const TypeMatcher<ArgumentError>()));
    });
  });

  group("Test update todo", () {
    Todo todo = createTodo();

    test("Update todo success", () {
      todoBox.put(todo);
      String expectedNewName = randomString(5);
      todo.name = expectedNewName;
      todoDao.update(todo);
      Todo? updatedTodo = todoBox.get(todo.obxId);

      expect(updatedTodo?.name, expectedNewName);
    });

    test("Update todo with unknown id should throw error", () {
      Todo todo = createTodo();
      expect(() => todoDao.update(todo),
          throwsA(const TypeMatcher<ArgumentError>()));
    });
  });

  group("Test get todo", () {
    List<Todo> expectedTodos = createListTodo();

    test("Get todo success", () {
      todoBox.putMany(expectedTodos);
      List<Todo> todos = todoDao.get();

      expect(todos, expectedTodos);
    });
  });
}
