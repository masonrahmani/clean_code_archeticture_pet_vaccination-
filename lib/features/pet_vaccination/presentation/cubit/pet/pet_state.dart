part of 'pet_cubit.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {
  @override
  List<Object> get props => [];
}

class PetLoading extends PetState {
  @override
  List<Object> get props => [];
}

class PetLoaded extends PetState {
  final List<PetEntities> pets;

  const PetLoaded({required this.pets});
  @override
  List<Object> get props => [pets];
}

class PetFaliare extends PetState {
  @override
  List<Object> get props => [];
}
