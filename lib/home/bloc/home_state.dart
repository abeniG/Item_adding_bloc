part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeItemsLoadedState extends HomeState {
  final List<Item> item;

  HomeItemsLoadedState({required this.item});
}
