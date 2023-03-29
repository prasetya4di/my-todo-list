import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/data/source/local/todo_dao.dart';
import 'package:my_todo_list/objectbox.g.dart';
import 'package:my_todo_list/repository/impl/todo_repository_impl.dart';
import 'package:my_todo_list/repository/todo_repository.dart';
import 'package:random_string/random_string.dart';

import '../util/dummy_builder.dart';
import 'todo_repository_test.mocks.dart';

@GenerateMocks([TodoDao])
void main() {
  late TodoDao mockTodoDao;
  late TodoRepository todoRepository;

  setUp(() {
    mockTodoDao = MockTodoDao();
    todoRepository = TodoRepositoryImpl(mockTodoDao);
  });

  group("Insert todo", () {
    int expectedId = randomBetween(0, 100);
    Todo todo = createTodo();

    test("Insert todo success", () {
      when(mockTodoDao.insert(todo)).thenReturn(expectedId);

      int insertedTodoId = todoRepository.insert(todo);

      verify(mockTodoDao.insert(todo));
      expect(insertedTodoId, expectedId);
    });

    test("Insert todo error should throw error", () {
      when(mockTodoDao.insert(todo))
          .thenThrow(ObjectBoxException(randomString(5)));

      verifyNever(mockTodoDao.insert(todo));
      expect(() => todoRepository.insert(todo),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });

  group("Update todo", () {
    Todo todo = createTodo();

    test("Update todo success", () {
      when(mockTodoDao.update(todo)).thenReturn(() {});
      todoRepository.update(todo);

      verify(mockTodoDao.update(todo));
    });

    test("Update todo error should throw error", () {
      when(mockTodoDao.update(todo))
          .thenThrow(ObjectBoxException(randomString(5)));

      expect(() => todoRepository.update(todo),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });

  group("Get todo", () {
    List<Todo> expectedTodos = createListTodo();

    test("Get todo success", () {
      when(mockTodoDao.get()).thenReturn(expectedTodos);

      List<Todo> todos = todoRepository.get();

      verify(mockTodoDao.get());
      expect(todos, expectedTodos);
    });
  });
}
