import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VaccinationEntities extends Equatable {
  final String? pid;
  final String? vid;
  final String? name;
  final String? date;
  final bool? done;

  const VaccinationEntities(
      {this.pid, this.vid, this.name, this.date, this.done});

  @override
  // TODO: implement props
  List<Object?> get props => [pid, vid, name, date, done];
}
