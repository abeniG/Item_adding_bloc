import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_bloc_example/data/mock/item_mock.dart';
import 'package:simple_bloc_example/data/model/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeItemsLoadedEvent>(homeItemsLoadedEvent);
    on<HomeItemsAddedEvent>(homeItemsAddedEvent);
    on<HomeItemsRemovedEvent>(homeItemsRemovedEvent);
  }

  FutureOr<void> homeItemsLoadedEvent(
      HomeItemsLoadedEvent event, Emitter<HomeState> emit) {
    emit(HomeItemsLoadedState(item: mockItems));
    print(
      'You have ${mockItems.length} items',
    );
  }

  FutureOr<void> homeItemsAddedEvent(
      HomeItemsAddedEvent event, Emitter<HomeState> emit) {
    mockItems.add(event.item);
    emit(HomeItemsLoadedState(item: mockItems));
  }

  FutureOr<void> homeItemsRemovedEvent(
      HomeItemsRemovedEvent event, Emitter<HomeState> emit) {
    mockItems.remove(event.item);
    emit(HomeItemsLoadedState(item: mockItems));
    print(
      '${event.item.name} is beign removed and you have ${mockItems.length} items left',
    );
  }
}
