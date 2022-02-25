import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

class VaccinationModel extends VaccinationEntities {
  const VaccinationModel({
    final String? pid,
    final String? vid,
    final String? name,
    final String? date,
    final bool? done,
  }) : super(
          pid: pid,
          vid: vid,
          name: name,
          date: date,
          done: done,
        );

  factory VaccinationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return VaccinationModel(
      pid: snapshot.get('pid'),
      vid: snapshot.get('vid'),
      name: snapshot.get('name'),
      date: snapshot.get('date'),
      done: snapshot.get('done'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "pid": pid,
      "vid": vid,
      "name": name,
      "date": date,
      "done": done,
    };
  }
}
