part of 'shared_units_bloc.dart';

sealed class SharedUnitsState extends Equatable {
  const SharedUnitsState();
  
  @override
  List<Object> get props => [];
}

final class SharedUnitsInitial extends SharedUnitsState {}
