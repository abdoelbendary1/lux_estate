part of 'recently_added_units_bloc.dart';

@immutable
sealed class RecentlyAddedUnitsEvent {}

final class LoadRecentlyAddedUnitsEvent extends RecentlyAddedUnitsEvent {
  LoadRecentlyAddedUnitsEvent();
}
