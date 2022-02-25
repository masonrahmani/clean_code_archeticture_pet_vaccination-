import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_vaccination/features/pet_vaccination/data/remote/data_source/remote_data_repository.dart';
import 'package:pet_vaccination/features/pet_vaccination/data/remote/models/pet_model.dart';
import 'package:pet_vaccination/features/pet_vaccination/data/remote/models/vaccination_model.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

class RemoteDataRepositoryImp implements RemotePetRepository {
  final FirebaseFirestore firebaseFirestore;

  RemoteDataRepositoryImp({required this.firebaseFirestore});

  @override
  Future<void> addNewPet(PetEntities petEntities) async {
    final petCollection = firebaseFirestore.collection("pets");
    final petReference = petCollection.doc().id;
    final newPet = PetModel(
      pid: petReference,
      name: petEntities.name,
      type: petEntities.type,
      notes: petEntities.notes,
    ).toDocument();

    petCollection.doc(petReference).get().then((pet) {
      if (!pet.exists) {
        petCollection.doc(petReference).set(newPet);
      }
    });
  }

  @override
  Future<void> deletePet(PetEntities petEntities) async {
    final petCollectionRef = firebaseFirestore.collection("pets");

    petCollectionRef.doc(petEntities.pid).get().then((pet) {
      if (pet.exists) {
        petCollectionRef.doc(petEntities.pid).delete();
      }
      return;
    });
  }

  @override
  Stream<List<PetEntities>> getPets() {
    final petCollection = firebaseFirestore.collection('pets');
    return petCollection.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => PetModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updatePet(PetEntities petEntities) async {
    Map<String, dynamic> pet = {};
    final petCollection = firebaseFirestore.collection('pets');
    if (petEntities.name != null) pet['name'] = petEntities.name;
    if (petEntities.notes != null) pet['notes'] = petEntities.notes;
    if (petEntities.type != null) pet['type'] = petEntities.type;
    petCollection.doc(petEntities.pid).update(pet);
  }

  @override
  Future<void> addVaccination(VaccinationEntities vaccinationEntities) async {
    final vaccinationRef = firebaseFirestore
        .collection("pets")
        .doc(vaccinationEntities.pid)
        .collection("vaccination");

    final vid = vaccinationRef.doc().id;

    vaccinationRef.doc(vid).get().then((vaccination) {
      final newVac = VaccinationModel(
        pid: vaccinationEntities.pid,
        vid: vid,
        name: vaccinationEntities.name,
        date: vaccinationEntities.date,
        done: vaccinationEntities.done,
      ).toDocument();

      if (!vaccination.exists) {
        vaccinationRef.doc(vid).set(newVac);
      }
      return;
    });
  }

  @override
  Future<void> deleteVaccination(
      VaccinationEntities vaccinationEntities) async {
    final noteCollectionRef = firebaseFirestore
        .collection("pets")
        .doc(vaccinationEntities.pid)
        .collection("vaccination");

    noteCollectionRef.doc(vaccinationEntities.vid).get().then((vaccination) {
      if (vaccination.exists) {
        noteCollectionRef.doc(vaccinationEntities.vid).delete();
      }
      return;
    });
  }

  @override
  Stream<List<VaccinationEntities>> getVaccination(String pid) {
    final vaccinationRef =
        firebaseFirestore.collection("pets").doc(pid).collection("vaccination");

    return vaccinationRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => VaccinationModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updateVaccination(
      VaccinationEntities vaccinationEntities) async {
    Map<String, dynamic> updateVac = VaccinationModel(
      vid: vaccinationEntities.vid,
      pid: vaccinationEntities.pid,
      name: vaccinationEntities.name,
      date: vaccinationEntities.date,
      done: vaccinationEntities.done,
    ).toDocument();

    firebaseFirestore
        .collection('pets')
        .doc(vaccinationEntities.pid)
        .collection("vaccination")
        .doc(vaccinationEntities.vid)
        .update(updateVac);
  }
}
