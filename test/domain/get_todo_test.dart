import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/get_todo.dart';
import 'package:my_todo_list/domain/impl/get_todo_impl.dart';
import 'package:my_todo_list/repository/todo_repository.dart';

import '../util/dummy_builder.dart';
import 'get_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late TodoRepository mockTodoRepository;
  late GetTodo getTodo;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    getTodo = GetTodoImpl(mockTodoRepository);
  });

  test("Get todo success", () {
    List<Todo> expectedTodos = createListTodo();

    when(mockTodoRepository.get()).thenReturn(expectedTodos);

    List<Todo> todos = getTodo();

    verify(mockTodoRepository.get());
    expect(todos, expectedTodos);
  });
}
