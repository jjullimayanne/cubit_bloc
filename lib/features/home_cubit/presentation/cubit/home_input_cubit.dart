//gerenciar estados
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_s/features/home_cubit/presentation/cubit/home_input_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  List<String> todos = [];

  Future<void> addTodo({required String todo}) async {
    emit(
      LoadingHomeState(),
    );
    await Future.delayed(
      const Duration(seconds: 5),
    );

    if (todos.contains(todo)) {
      emit(ErrorHomeState(message: 'error'));
    } else {
      todos.add(todo);
      emit(LoadedHomeState(todos: todos));
    }
  }

  Future<void> removeTodo({required int index}) async {
    emit(
      LoadingHomeState(),
    );
    await Future.delayed(
      const Duration(seconds: 5),
    );
    todos.removeAt(index);
    emit(LoadedHomeState(todos: todos));
  }
}
