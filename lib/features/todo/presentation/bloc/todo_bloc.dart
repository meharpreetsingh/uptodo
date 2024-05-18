import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:uptodo/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:uptodo/features/todo/domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required GetTodos getTodos, required UpdateTodo updateTodo, required CreateTodo createTodo})
      : _getTodosUsecase = getTodos,
        _updateTodoUsecase = updateTodo,
        _createTodoUsecase = createTodo,
        super(TodoInitial()) {
    on<TodoEvent>((event, emit) {});
    on<GetTodosEvent>(_getTodos);
    on<UpdateTodoEvent>(_updateTodo);
    on<CreateTodoEvent>(_createTodo);
  }

  final GetTodos _getTodosUsecase;
  final UpdateTodo _updateTodoUsecase;
  final CreateTodo _createTodoUsecase;
  StreamSubscription<List<Todo>>? _todoStreamSubscription;

  @override
  Future<void> close() {
    _todoStreamSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _getTodos(GetTodosEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    final result = _getTodosUsecase(GetTodosParams(event.uid));
    return result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todoStream) => emit.forEach(
        todoStream,
        onData: (data) {
          return TodoLoaded(data);
        },
      ),
    );
    // _todoStreamSubscription?.cancel();
    // _todoStreamSubscription = todoStream.listen((todos) => emit(TodoLoaded(todos)));
  }

  FutureOr<void> _updateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _updateTodoUsecase(event.todo);
    return result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todo) {
        // TODO: Implement update todo
      },
    );
  }

  FutureOr<void> _createTodo(CreateTodoEvent event, Emitter<TodoState> emit) async {
    final result = await _createTodoUsecase(event.todo);
    result.fold((failure) => emit(TodoError(failure.message)), (todo) {
      // TODO: Implement create todo
    });
  }
}
