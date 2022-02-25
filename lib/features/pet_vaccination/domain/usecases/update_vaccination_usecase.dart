import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

import '../repository/pet_repository.dart';

class UpdateVaccinationUsecase {
  final PetRepository petRepository;

  UpdateVaccinationUsecase({required this.petRepository});
  Future<void> call(VaccinationEntities vaccinationEntities) async =>
      petRepository.updateVaccination(vaccinationEntities);
}
