import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/vaccination/vaccination_cubit.dart';

class AddVaccinationDialog extends StatefulWidget {
  final String pid;
  const AddVaccinationDialog({Key? key, required this.pid}) : super(key: key);

  @override
  _AddVaccinationDialogState createState() => _AddVaccinationDialogState();
}

class _AddVaccinationDialogState extends State<AddVaccinationDialog> {
  String? name;
  String? date;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Vaccination'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter vaccination name'),
                onChanged: (text) => name = text,
              ),
              DateTimePicker(
                initialValue: '',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => date = val,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).indicatorColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).indicatorColor,
                      ),
                      onPressed: () {
                        if (date != null && name != null) {
                          final newVac = VaccinationEntities(
                            pid: widget.pid,
                            name: name,
                            date: date,
                            done: false,
                          );
                          BlocProvider.of<VaccinationCubit>(context)
                              .addVaccinaion(vaccinationEntities: newVac);
                        }

                        Navigator.of(context).pop();
                      },
                      child: Text("Save")),
                ],
              ),
            ],
          ),
        ));
  }
}
