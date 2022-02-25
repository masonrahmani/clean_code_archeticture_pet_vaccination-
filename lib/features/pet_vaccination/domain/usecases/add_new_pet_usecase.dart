import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/repository/pet_repository.dart';

class AddNewPetUsecase {
  final PetRepository petRepository;

  AddNewPetUsecase({required this.petRepository});
  Future<void> call(PetEntities petEntities) async =>
      petRepository.addNewPet(petEntities);
}
