import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc_example/data/mock/item_mock.dart';
import 'package:simple_bloc_example/data/model/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Item> items = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeItemsLoadedEvent>(homeItemsLoadedEvent);
    on<HomeItemsAddedEvent>(homeItemsAddedEvent);
    on<HomeItemsRemovedEvent>(homeItemsRemovedEvent);
  }

  FutureOr<void> homeItemsLoadedEvent(
      HomeItemsLoadedEvent event, Emitter<HomeState> emit) {
    items.clear();
    items.addAll(mockItems);

    emit(HomeItemsLoadedState(item: List.from(items)));

    print('You have ${items.length} items');
  }

  FutureOr<void> homeItemsAddedEvent(
      HomeItemsAddedEvent event, Emitter<HomeState> emit) {
    items.add(event.item);

    emit(HomeItemsLoadedState(item: List.from(items)));
  }

  FutureOr<void> homeItemsRemovedEvent(
      HomeItemsRemovedEvent event, Emitter<HomeState> emit) {
    items.remove(event.item);

    emit(HomeItemsLoadedState(item: List.from(items)));

    print('${event.item.name} removed. ${items.length} items left');
  }
}
