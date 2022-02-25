import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/vaccination/vaccination_cubit.dart';

class VaccinationList extends StatefulWidget {
  final String pid;
  final Widget Function(VaccinationEntities) buildRow;
  const VaccinationList({Key? key, required this.pid, required this.buildRow})
      : super(key: key);

  @override
  State<VaccinationList> createState() => _VaccinationListState();
}

class _VaccinationListState extends State<VaccinationList> {
  @override
  void initState() {
    BlocProvider.of<VaccinationCubit>(context).getVaccinations(widget.pid);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VaccinationCubit, VaccinationState>(
      builder: (context, vacState) {
        if (vacState is VaccinationLoaded) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 6.0),
              const Text(
                'Vaccinations',
                style: TextStyle(fontSize: 16.0),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: vacState.vaccinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.buildRow(vacState.vaccinations[index]);
                  },
                ),
              ),
            ],
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
