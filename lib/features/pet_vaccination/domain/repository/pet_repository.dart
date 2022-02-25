import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

import '../entities/pet_entities.dart';

abstract class PetRepository {
  //pets
  Stream<List<PetEntities>> getPets();
  Future<void> addNewPet(PetEntities petEntities);
  Future<void> updatePet(PetEntities petEntities);
  Future<void> deletePet(PetEntities petEntities);

  // vaccination
  Stream<List<VaccinationEntities>> getVaccination(String pid);
  Future<void> addVaccination(VaccinationEntities vaccinationEntities);
  Future<void> deleteVaccination(VaccinationEntities vaccinationEntities);
  Future<void> updateVaccination(VaccinationEntities vaccinationEntities);
}
