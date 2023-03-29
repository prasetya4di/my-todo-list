import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/add_todo.dart';
import 'package:my_todo_list/domain/finish_todo.dart';
import 'package:my_todo_list/domain/get_todo.dart';
import 'package:my_todo_list/view/todo/bloc/todo_bloc.dart';
import 'package:my_todo_list/view/todo/bloc/todo_state.dart';

import '../util/dummy_builder.dart';
import 'todo_bloc_test.mocks.dart';

@GenerateMocks([AddTodo, FinishTodo, GetTodo])
void main() {
  late AddTodo mockAddTodo;
  late FinishTodo mockFinishTodo;
  late GetTodo mockGetTodo;
  late TodoBloc todoBloc;
  List<Todo> expectedTodos = createListTodo();

  setUp(() {
    mockAddTodo = MockAddTodo();
    mockFinishTodo = MockFinishTodo();
    mockGetTodo = MockGetTodo();
    todoBloc = TodoBloc(mockAddTodo, mockFinishTodo, mockGetTodo);
  });

  tearDown(() {
    todoBloc.close();
  });

  blocTest<TodoBloc, TodoState>(
      "emit [LoadingState, LoadedState] states for successful get all todo",
      build: () => todoBloc,
      act: (bloc) => bloc.add(const GetTodoEvent()),
      expect: () => [const TodoState.loading(), const TodoState.loaded()],
      setUp: () {
        when(mockGetTodo()).thenReturn(expectedTodos);
      },
      verify: (bloc) {
        verify(mockGetTodo());
        expect(bloc.todos, expectedTodos);
      });

  group("Add todo event", () {
    Todo expectedNewTodo = createTodo();

    blocTest<TodoBloc, TodoState>(
        "emit [LoadingState, AddedState] states for successful add new todo",
        build: () => todoBloc,
        act: (bloc) => bloc.add(AddTodoEvent(expectedNewTodo.name)),
        expect: () => [const TodoState.loading(), const TodoState.added()],
        setUp: () {
          when(mockAddTodo(expectedNewTodo)).thenReturn(expectedNewTodo);
        },
        verify: (bloc) {
          verify(mockAddTodo(expectedNewTodo));
          expect(bloc.todos, [expectedNewTodo]);
        });
  });

  group("Finish todo event", () {
    Todo expectedFinishTodo = createTodo();

    blocTest<TodoBloc, TodoState>(
        "emit [LoadingState, FinishedState] states for successful finish todo",
        build: () => todoBloc,
        act: (bloc) {
          bloc.add(AddTodoEvent(expectedFinishTodo.name));
          bloc.add(FinishTodoEvent(expectedFinishTodo));
        },
        expect: () => [
              const TodoState.loading(),
              const TodoState.added(),
              const TodoState.loading(),
              const TodoState.finished()
            ],
        setUp: () {
          when(mockFinishTodo(expectedFinishTodo))
              .thenReturn(expectedFinishTodo);
          when(mockAddTodo(expectedFinishTodo)).thenReturn(expectedFinishTodo);
        },
        verify: (bloc) {
          verify(mockFinishTodo(expectedFinishTodo));
          expect(bloc.todos, [expectedFinishTodo]);
        });
  });
}
