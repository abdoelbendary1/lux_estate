// A standard way to represent any async operation
abstract class AsyncState<T> {
  final T? data;
  final String? errorMessage;
  final bool isLoading;

  const AsyncState({this.data, this.errorMessage, this.isLoading = false});
}

class DataInitial extends AsyncState<Never> {
  const DataInitial() : super(isLoading: false);
}

// Concrete implementations that look the same everywhere
class DataLoading extends AsyncState<Never> {
  const DataLoading() : super(isLoading: true);
}

class DataSuccess<T> extends AsyncState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed extends AsyncState<Never> {
  const DataFailed(String message) : super(errorMessage: message);
}
