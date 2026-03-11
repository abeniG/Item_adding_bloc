import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_example/data/mock/item_mock.dart';
import 'package:simple_bloc_example/data/model/item_model.dart';
import 'package:simple_bloc_example/home/bloc/home_bloc.dart';
import 'package:simple_bloc_example/home/ui/form.dart';
import 'package:simple_bloc_example/home/ui/item_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  bool isLoading = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    homeBloc.add(HomeItemsLoadedEvent());
    Future.delayed(
      Duration(seconds: 3),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME PAGE',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          switch (state) {
            case HomeItemsLoadedState():
              final successState = HomeItemsLoadedState(item: mockItems);
              return mockItems.isEmpty
                  ? const Center(child: Text('NO ITEMS FOUND'))
                  : ItemTile(homeBloc: homeBloc);
            default:
          }
          return Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('NO ITEMS FOUND'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: ItemForm(
                    nameController: nameController,
                    priceController: priceController,
                    descriptionController: descriptionController,
                    imageController: imageController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () {
                          homeBloc.add(HomeItemsAddedEvent(
                              item: Item(
                                  name: nameController.value.text.trim(),
                                  description:
                                      descriptionController.value.text.trim(),
                                  imageUrl: imageController.value.text.trim(),
                                  price: double.parse(
                                      priceController.value.text.trim()))));
                          print('Saved ${nameController.text}');
                          Navigator.pop(context);
                          nameController.text = '';
                          priceController.text = '';
                          imageController.text = '';
                          descriptionController.text = '';
                        },
                        child: const Text('Save'))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
