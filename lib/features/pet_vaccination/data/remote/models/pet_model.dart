import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/pet_entities.dart';

class PetModel extends PetEntities {
  const PetModel({
    final String? pid,
    final String? name,
    final String? type,
    final String? notes,
  }) : super(
          pid: pid,
          name: name,
          type: type,
          notes: notes,
        );

  factory PetModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PetModel(
      pid: snapshot.get('pid'),
      name: snapshot.get('name'),
      type: snapshot.get('type'),
      notes: snapshot.get('notes'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "pid": pid,
      "name": name,
      "type": type,
      "notes": notes,
    };
  }
}
