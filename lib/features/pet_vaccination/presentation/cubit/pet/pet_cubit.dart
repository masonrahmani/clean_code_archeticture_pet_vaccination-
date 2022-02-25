import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/pet_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/add_new_pet_usecase.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/delete_pet_usecase.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/get_pets_usecase.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/update_pet_usecase.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final GetPetUsecase getPetUsecase;
  final AddNewPetUsecase addNewPetUsecase;
  final UpdatePetUsecase updatePetUsecase;
  final DeletePetUsecase deletePetUsecase;
  PetCubit(
      {required this.getPetUsecase,
      required this.addNewPetUsecase,
      required this.updatePetUsecase,
      required this.deletePetUsecase})
      : super(PetInitial());

  Future<void> getPets() async {
    emit(PetLoading());
    try {
      getPetUsecase.call().listen((pets) {
        emit(PetLoaded(pets: pets));
      });
    } on SocketException catch (_) {
      emit(PetFaliare());
    } catch (_) {
      emit(PetFaliare());
    }
  }

  Future<void> addPet({required PetEntities petEntities}) async {
    try {
      await addNewPetUsecase.call(petEntities);
    } on SocketException catch (_) {
      emit(PetFaliare());
    } catch (_) {
      emit(PetFaliare());
    }
  }

  Future<void> updatePet({required PetEntities petEntities}) async {
    try {
      await updatePetUsecase.call(petEntities);
    } on SocketException catch (_) {
      emit(PetFaliare());
    } catch (_) {
      emit(PetFaliare());
    }
  }

  Future<void> deletePet({required PetEntities petEntities}) async {
    try {
      await deletePetUsecase.call(petEntities);
    } on SocketException catch (_) {
      emit(PetFaliare());
    } catch (_) {
      emit(PetFaliare());
    }
  }
}
