import 'package:flutter/material.dart';
import 'package:pet_vaccination/core/constant.dart';

import '../features/pet_vaccination/domain/entities/pet_entities.dart';
import '../features/pet_vaccination/presentation/pages/pet_details.dart';
import '../features/pet_vaccination/presentation/widgets/add_pet_dialog.dart';
import '../features/pet_vaccination/presentation/widgets/add_vaccination_dialog.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.addPetPage:
        {
          return materialBuilder(widget: const AddPetDialog());
        }
      case PageConst.addVaccinationPage:
        {
          if (args is String) {
            return materialBuilder(widget: AddVaccinationDialog(pid: args));
          }
          return materialBuilder(widget: const ErrorPage());
        }
      case PageConst.petDetails:
        {
          if (args is PetEntities) {
            return materialBuilder(
                widget: PetDetail(
              pet: args,
            ));
          }
          return materialBuilder(widget: const ErrorPage());
        }

      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
