import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/domain/usecases/get_todos_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required GetTodos getTodos})
      : _getTodosUsecase = getTodos,
        super(TodoInitial()) {
    on<TodoEvent>((event, emit) {});
    on<GetTodosEvent>(_getTodos);
  }

  final GetTodos _getTodosUsecase;
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
}