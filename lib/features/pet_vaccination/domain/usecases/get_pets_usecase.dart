import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/repository/pet_repository.dart';

class GetPetUsecase {
  final PetRepository petRepository;

  GetPetUsecase({required this.petRepository});
  Stream<List<PetEntities>> call() => petRepository.getPets();
}
