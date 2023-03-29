import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/finish_todo.dart';
import 'package:my_todo_list/domain/impl/finish_todo_impl.dart';
import 'package:my_todo_list/objectbox.g.dart';
import 'package:my_todo_list/repository/todo_repository.dart';
import 'package:random_string/random_string.dart';

import '../util/dummy_builder.dart';
import 'finish_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late TodoRepository mockTodoRepository;
  late FinishTodo finishTodo;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    finishTodo = FinishTodoImpl(mockTodoRepository);
  });

  group("Finish todo", () {
    Todo todo = createTodo();

    test("Finish todo success", () {
      when(mockTodoRepository.update(todo)).thenReturn(() {});
      Todo updatedTodo = finishTodo(todo);

      verify(mockTodoRepository.update(todo));
      expect(updatedTodo.finishedDate != null, true);
    });

    test("Finish todo error should throw error", () {
      when(mockTodoRepository.update(todo))
          .thenThrow(ObjectBoxException(randomString(5)));

      expect(() => mockTodoRepository.update(todo),
          throwsA(const TypeMatcher<ObjectBoxException>()));
    });
  });
}
