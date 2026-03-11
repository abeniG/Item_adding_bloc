import 'package:flutter/material.dart';
import 'package:simple_bloc_example/data/model/item_model.dart';
import 'package:simple_bloc_example/home/bloc/home_bloc.dart';

class ItemTile extends StatelessWidget {
  final List<Item> items;
  final HomeBloc homeBloc;

  const ItemTile({
    super.key,
    required this.items,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  '${index + 1}. ${item.name.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Image.network(item.imageUrl),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRICE: \$${item.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        homeBloc.add(
                          HomeItemsRemovedEvent(item: item),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
