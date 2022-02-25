import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_vaccination/core/constant.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/pet/pet_cubit.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/vaccination/vaccination_cubit.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/pages/vaccination_list.dart';

import '../widgets/choose_chips.dart';
import '../widgets/text_field.dart';

class PetDetail extends StatefulWidget {
  final PetEntities pet;

  const PetDetail({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  late List<CategoryOption> animalTypes;
  late String name;
  late String type;
  String? notes;

  @override
  void initState() {
    BlocProvider.of<VaccinationCubit>(context).getVaccinations(widget.pet.pid!);
    type = widget.pet.type!;
    name = widget.pet.name!;
    animalTypes = [
      CategoryOption(type: 'cat', name: 'Cat', isSelected: type == 'cat'),
      CategoryOption(type: 'dog', name: 'Dog', isSelected: type == 'dog'),
      CategoryOption(type: 'other', name: 'Other', isSelected: type == 'other'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool vacDone;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.pet.name!),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        height: double.infinity,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                UserTextField(
                  name: 'Pet Name',
                  initialValue: widget.pet.name!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please input name';
                    }
                  },
                  inputType: TextInputType.name,
                  onChanged: (value) => name = value ?? name,
                ),
                ChooseType(
                  title: 'Animal Type',
                  options: animalTypes,
                  onOptionTap: (value) {
                    setState(() {
                      animalTypes.forEach((element) {
                        type = value.type;
                        element.isSelected = element.type == value.type;
                      });
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                UserTextField(
                  name: 'notes',
                  initialValue: widget.pet.notes ?? '',
                  validator: (value) {},
                  inputType: TextInputType.text,
                  onChanged: (value) => notes = value,
                ),
                VaccinationList(pid: widget.pet.pid!, buildRow: buildRow),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageConst.addVaccinationPage,
                        arguments: widget.pet.pid);
                  },
                  tooltip: 'Add Vaccination',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        color: Theme.of(context).indicatorColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<PetCubit>(context)
                              .deletePet(petEntities: widget.pet);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )),
                    MaterialButton(
                      color: Theme.of(context).indicatorColor,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop();
                          final updatePet = PetEntities(
                              pid: widget.pet.pid,
                              name: name,
                              type: type,
                              notes: notes);

                          BlocProvider.of<PetCubit>(context)
                              .updatePet(petEntities: updatePet);
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(VaccinationEntities vaccination) {
    return GestureDetector(
      onLongPress: () => deleteVaccination(vaccination),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(vaccination.name!),
          ),
          Text(vaccination.date!),
          Checkbox(
            value: vaccination.done,
            onChanged: (newValue) {
              final updateVac = VaccinationEntities(
                vid: vaccination.vid,
                pid: vaccination.pid,
                name: vaccination.name,
                date: vaccination.date,
                done: newValue,
              );
              BlocProvider.of<VaccinationCubit>(context)
                  .updateVaccination(vaccinationEntities: updateVac);
            },
          )
        ],
      ),
    );
  }

  Future<dynamic> deleteVaccination(VaccinationEntities vaccination) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Vaccination"),
          content: Text("are you sure you want to delete this vaccination."),
          actions: [
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                BlocProvider.of<VaccinationCubit>(context)
                    .deleteVaccination(vaccinationEntities: vaccination);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
