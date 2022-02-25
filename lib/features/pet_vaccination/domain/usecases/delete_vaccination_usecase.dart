import '../entities/vaccination_entities.dart';
import '../repository/pet_repository.dart';

class DeleteVaccinationUsecase {
  final PetRepository petRepository;

  DeleteVaccinationUsecase({required this.petRepository});
  Future<void> call(VaccinationEntities vaccinationEntities) async =>
      petRepository.deleteVaccination(vaccinationEntities);
}
