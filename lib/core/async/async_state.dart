import 'package:equatable/equatable.dart';

abstract class AsyncState<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final bool isLoading;

  const AsyncState({this.data, this.errorMessage, this.isLoading = false});

  @override
  List<Object?> get props => [data, errorMessage, isLoading];
}

class DataInitial extends AsyncState<Never> {
  const DataInitial() : super(isLoading: false);
}

class DataLoading extends AsyncState<Never> {
  const DataLoading() : super(isLoading: true);
}

class DataSuccess<T> extends AsyncState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  List<Object?> get props => [data]; // Specifically compare the data payload
}

class DataFailed extends AsyncState<Never> {
  final String message;
  const DataFailed(this.message) : super(errorMessage: message);

  @override
  List<Object?> get props => [message]; // Specifically compare the error string
}
