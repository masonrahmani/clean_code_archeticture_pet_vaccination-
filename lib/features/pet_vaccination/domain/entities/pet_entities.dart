import 'package:equatable/equatable.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';

class PetEntities extends Equatable {
  final String? pid;
  final String? name;
  final String? type;
  final String? notes;
  final List<VaccinationEntities>? vaccination;

  const PetEntities(
      {this.pid, this.name, this.type, this.notes, this.vaccination});

  @override
  List<Object?> get props => [pid, name, type, notes, vaccination];
}
