import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/pet/pet_cubit.dart';
import '../../../../core/constant.dart';

class PetPage extends StatefulWidget {
  const PetPage({Key? key}) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  void initState() {
    BlocProvider.of<PetCubit>(context).getPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pets"),
        centerTitle: true,
      ),
      body: BlocBuilder<PetCubit, PetState>(builder: (context, petState) {
        if (petState is PetLoaded) {
          if (petState.pets.isNotEmpty) {
            return _createListWidget(petState);
          }
        }
        if (petState is PetFaliare) {
          return Center(child: Text("Failire"));
        }

        return Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            PageConst.addPetPage,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createListWidget(PetLoaded petState) {
    return ListView.builder(
      itemCount: petState.pets.length,
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PageConst.petDetails,
                arguments: petState.pets[index],
              );
            },
            onLongPress: () {
              deletePet(petState, index);
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: const Offset(0, 1.5))
                    ]),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(6),
                child: Text(
                  petState.pets[index].name!,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                )));
      },
    );
  }

  Future<dynamic> deletePet(PetLoaded petState, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Note"),
          content: Text("are you sure you want to delete this note."),
          actions: [
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                BlocProvider.of<PetCubit>(context)
                    .deletePet(petEntities: petState.pets[index]);
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
