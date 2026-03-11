import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    homeBloc.add(HomeItemsLoadedEvent());

    Future.delayed(
      const Duration(seconds: 3),
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

  void clearForm() {
    nameController.clear();
    priceController.clear();
    imageController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME PAGE'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeItemsLoadedState) {
            if (state.item.isEmpty) {
              return const Center(child: Text('NO ITEMS FOUND'));
            }

            return ItemTile(
              items: state.item,
              homeBloc: homeBloc,
            );
          }

          return Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('NO ITEMS FOUND'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add),
        label: const Text("Add Item"),
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
                      final price =
                          double.tryParse(priceController.text.trim()) ?? 0;

                      homeBloc.add(
                        HomeItemsAddedEvent(
                          item: Item(
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim(),
                            imageUrl: imageController.text.trim(),
                            price: price,
                          ),
                        ),
                      );

                      clearForm();

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
