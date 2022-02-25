import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

import '../repository/pet_repository.dart';

class GetVaccinationUsecase {
  final PetRepository petRepository;

  GetVaccinationUsecase({required this.petRepository});
  Stream<List<VaccinationEntities>> call(String pid) =>
      petRepository.getVaccination(pid);
}
