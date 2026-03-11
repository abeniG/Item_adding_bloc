import 'package:flutter/material.dart';
import 'package:simple_bloc_example/data/mock/item_mock.dart';
import 'package:simple_bloc_example/home/bloc/home_bloc.dart';

class ItemTile extends StatelessWidget {
  final HomeBloc homeBloc;
  const ItemTile({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockItems.length,
      itemBuilder: ((context, index) {
        return Card(
          child: Column(
            children: [
              Text(
                '${index + 1}, ${mockItems[index].name.toUpperCase()}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Image.network(mockItems[index].imageUrl),
              Text(
                mockItems[index].description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PRICE: \$${mockItems[index].price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        homeBloc
                            .add(HomeItemsRemovedEvent(item: mockItems[index]));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
