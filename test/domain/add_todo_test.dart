import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/add_todo.dart';
import 'package:my_todo_list/domain/impl/add_todo_impl.dart';
import 'package:my_todo_list/objectbox.g.dart';
import 'package:my_todo_list/repository/todo_repository.dart';
import 'package:random_string/random_string.dart';

import '../util/dummy_builder.dart';
import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late TodoRepository mockTodoRepository;
  late AddTodo addTodo;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    addTodo = AddTodoImpl(mockTodoRepository);
  });

  group("Add todo", () {
    int expectedId = randomBetween(0, 100);
    Todo todo = createTodo();

    test("Add todo success", () {
      when(mockTodoRepository.insert(todo)).thenReturn(expectedId);

      Todo insertedTodo = addTodo(todo);

      verify(mockTodoRepository.insert(todo));
      expect(insertedTodo.obxId, expectedId);
    });

    test("Add todo error should throw error", () {
      when(mockTodoRepository.insert(todo))
          .thenThrow(ObjectBoxException(randomString(5)));

      verifyNever(mockTodoRepository.insert(todo));
      expect(() => addTodo(todo),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
