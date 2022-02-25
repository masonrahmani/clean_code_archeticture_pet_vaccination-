import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_vaccination/features/pet_vaccination/presentation/cubit/vaccination/vaccination_cubit.dart';

import '../features/pet_vaccination/data/remote/data_source/remote_data_repository.dart';
import '../features/pet_vaccination/data/remote/data_source/remote_data_repository_imp.dart';
import '../features/pet_vaccination/data/repositories/note_repository_imp.dart';
import '../features/pet_vaccination/domain/repository/pet_repository.dart';
import '../features/pet_vaccination/domain/usecases/add_new_pet_usecase.dart';
import '../features/pet_vaccination/domain/usecases/add_vaccination_usecase.dart';
import '../features/pet_vaccination/domain/usecases/delete_pet_usecase.dart';
import '../features/pet_vaccination/domain/usecases/delete_vaccination_usecase.dart';
import '../features/pet_vaccination/domain/usecases/get_pets_usecase.dart';
import '../features/pet_vaccination/domain/usecases/get_vaccination_usecase.dart';
import '../features/pet_vaccination/domain/usecases/update_pet_usecase.dart';
import '../features/pet_vaccination/domain/usecases/update_vaccination_usecase.dart';
import '../features/pet_vaccination/presentation/cubit/pet/pet_cubit.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
//CUBIT/ BLOC

  sl.registerFactory<PetCubit>(() => PetCubit(
        updatePetUsecase: sl.call(),
        getPetUsecase: sl.call(),
        deletePetUsecase: sl.call(),
        addNewPetUsecase: sl.call(),
      ));

  sl.registerFactory<VaccinationCubit>(() => VaccinationCubit(
        getVaccinationUsecase: sl.call(),
        deleteVaccinationUsecase: sl.call(),
        addVaccinationUsecase: sl.call(),
        updateVaccinationUsecase: sl.call(),
      ));
//USECASE
  sl.registerLazySingleton<AddNewPetUsecase>(
      () => AddNewPetUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<DeletePetUsecase>(
      () => DeletePetUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<GetPetUsecase>(
      () => GetPetUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<UpdatePetUsecase>(
      () => UpdatePetUsecase(petRepository: sl.call()));

  sl.registerLazySingleton<AddVaccinationUsecase>(
      () => AddVaccinationUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<DeleteVaccinationUsecase>(
      () => DeleteVaccinationUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<GetVaccinationUsecase>(
      () => GetVaccinationUsecase(petRepository: sl.call()));
  sl.registerLazySingleton<UpdateVaccinationUsecase>(
      () => UpdateVaccinationUsecase(petRepository: sl.call()));

// REPOSITORY

  sl.registerLazySingleton<PetRepository>(
      () => PetRepositoryImp(remotePetRepository: sl.call()));
//DATA SOURSE

  sl.registerLazySingleton<RemotePetRepository>(
      () => RemoteDataRepositoryImp(firebaseFirestore: sl.call()));
//EXTERNAL

  final firebaseFireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firebaseFireStore);
}
