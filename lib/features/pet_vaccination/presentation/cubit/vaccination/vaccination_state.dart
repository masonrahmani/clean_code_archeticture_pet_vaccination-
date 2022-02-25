part of 'vaccination_cubit.dart';

abstract class VaccinationState extends Equatable {
  const VaccinationState();

  @override
  List<Object> get props => [];
}

class VaccinationInitial extends VaccinationState {}

class VaccinationLoading extends VaccinationState {}

class VaccinationLoaded extends VaccinationState {
  final List<VaccinationEntities> vaccinations;

  const VaccinationLoaded({required this.vaccinations});
  @override
  List<Object> get props => [vaccinations];
}

class VaccinationFaliare extends VaccinationState {}
