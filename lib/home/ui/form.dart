import 'package:flutter/material.dart';

class ItemForm extends StatelessWidget {
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController descriptionController;
  TextEditingController imageController;
  ItemForm(
      {super.key,
      required this.nameController,
      required this.priceController,
      required this.descriptionController,
      required this.imageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.4,
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(label: Text('NAME')),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(label: Text('DESCRIPTION')),
          ),
          TextField(
            controller: imageController,
            decoration: const InputDecoration(label: Text('IMAGE')),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(label: Text('PRICE')),
          )
        ],
      ),
    );
  }
}
