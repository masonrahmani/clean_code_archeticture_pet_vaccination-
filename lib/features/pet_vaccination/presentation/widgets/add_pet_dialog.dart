import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';

import '../cubit/pet/pet_cubit.dart';

class AddPetDialog extends StatefulWidget {
  const AddPetDialog({Key? key}) : super(key: key);

  @override
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  String? petName;
  String character = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Pet'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a Pet Name'),
                onChanged: (text) => petName = text,
              ),
              RadioListTile(
                title: const Text('Cat'),
                value: 'cat',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Dog'),
                value: 'dog',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Other'),
                value: 'other',
                groupValue: character,
                onChanged: (value) {
                  setState(() {
                    character = (value ?? '') as String;
                  });
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).indicatorColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).indicatorColor,
                  ),
                  onPressed: () {
                    if (petName != null && character.isNotEmpty) {
                      final newPet = PetEntities(
                        name: petName,
                        type: character,
                        notes: "",
                      );

                      BlocProvider.of<PetCubit>(context)
                          .addPet(petEntities: newPet);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add')),
            ],
          )
        ]);
  }
}
