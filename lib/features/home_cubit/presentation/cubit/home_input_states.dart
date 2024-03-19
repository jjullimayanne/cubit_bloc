abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<String> todos;

  LoadedHomeState({
    required this.todos,
  });
}

class ErrorHomeState extends HomeState {
  final String message;
  ErrorHomeState({
    required this.message,
  });
}
