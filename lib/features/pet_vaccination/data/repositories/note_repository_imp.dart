import 'package:pet_vaccination/features/pet_vaccination/data/remote/data_source/remote_data_repository.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/repository/pet_repository.dart';

class PetRepositoryImp extends PetRepository {
  final RemotePetRepository remotePetRepository;

  PetRepositoryImp({required this.remotePetRepository});

  @override
  Future<void> addNewPet(PetEntities petEntities) async =>
      remotePetRepository.addNewPet(petEntities);

  @override
  Future<void> deletePet(PetEntities petEntities) async =>
      remotePetRepository.deletePet(petEntities);

  @override
  Stream<List<PetEntities>> getPets() => remotePetRepository.getPets();

  @override
  Future<void> updatePet(PetEntities petEntities) async =>
      remotePetRepository.updatePet(petEntities);

  @override
  Future<void> addVaccination(VaccinationEntities vaccinationEntities) async =>
      remotePetRepository.addVaccination(vaccinationEntities);

  @override
  Future<void> deleteVaccination(
          VaccinationEntities vaccinationEntities) async =>
      remotePetRepository.deleteVaccination(vaccinationEntities);
  @override
  Stream<List<VaccinationEntities>> getVaccination(String pid) =>
      remotePetRepository.getVaccination(pid);

  @override
  Future<void> updateVaccination(
          VaccinationEntities vaccinationEntities) async =>
      remotePetRepository.updateVaccination(vaccinationEntities);
}
