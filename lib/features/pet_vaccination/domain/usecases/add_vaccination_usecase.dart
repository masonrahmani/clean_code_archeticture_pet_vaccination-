import '../entities/vaccination_entities.dart';
import '../repository/pet_repository.dart';

class AddVaccinationUsecase {
  final PetRepository petRepository;

  AddVaccinationUsecase({required this.petRepository});
  Future<void> call(VaccinationEntities vaccinationEntities) async =>
      petRepository.addVaccination(vaccinationEntities);
}
