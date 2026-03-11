part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeItemsLoadedEvent extends HomeEvent {}

final class HomeItemsAddedEvent extends HomeEvent {
  final Item item;

  HomeItemsAddedEvent({required this.item});
}

final class HomeItemsRemovedEvent extends HomeEvent {
  final Item item;

  HomeItemsRemovedEvent({required this.item});
}
