import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/entities/vaccination_entities.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/add_vaccination_usecase.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/delete_vaccination_usecase.dart';
import 'package:pet_vaccination/features/pet_vaccination/domain/usecases/update_vaccination_usecase.dart';
import '../../../domain/usecases/get_vaccination_usecase.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends Cubit<VaccinationState> {
  final GetVaccinationUsecase getVaccinationUsecase;
  final AddVaccinationUsecase addVaccinationUsecase;
  final DeleteVaccinationUsecase deleteVaccinationUsecase;
  final UpdateVaccinationUsecase updateVaccinationUsecase;

  VaccinationCubit(
      {required this.getVaccinationUsecase,
      required this.addVaccinationUsecase,
      required this.deleteVaccinationUsecase,
      required this.updateVaccinationUsecase})
      : super(VaccinationInitial());

  Future<void> getVaccinations(String uid) async {
    emit(VaccinationLoading());
    try {
      getVaccinationUsecase.call(uid).listen((vaccinations) {
        emit(VaccinationLoaded(vaccinations: vaccinations));
      });
    } on SocketException catch (_) {
      emit(VaccinationFaliare());
    } catch (_) {
      emit(VaccinationFaliare());
    }
  }

  Future<void> addVaccinaion(
      {required VaccinationEntities vaccinationEntities}) async {
    try {
      await addVaccinationUsecase.call(vaccinationEntities);
    } on SocketException catch (_) {
      emit(VaccinationFaliare());
    } catch (_) {
      emit(VaccinationFaliare());
    }
  }

  Future<void> deleteVaccination(
      {required VaccinationEntities vaccinationEntities}) async {
    try {
      await deleteVaccinationUsecase.call(vaccinationEntities);
    } on SocketException catch (_) {
      emit(VaccinationFaliare());
    } catch (_) {
      emit(VaccinationFaliare());
    }
  }

  Future<void> updateVaccination(
      {required VaccinationEntities vaccinationEntities}) async {
    try {
      await updateVaccinationUsecase.call(vaccinationEntities);
    } on SocketException catch (_) {
      emit(VaccinationFaliare());
    } catch (_) {
      emit(VaccinationFaliare());
    }
  }
}
