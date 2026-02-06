import 'package:get_it/get_it.dart';
import 'package:yuk_baca_quran/core/network/dio_client.dart';
import 'package:yuk_baca_quran/core/usecase/home_usecase.dart';
import 'package:yuk_baca_quran/data/repository/home_repository.dart';
import 'package:yuk_baca_quran/ui/home/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  homeInit();
}

void homeInit() {
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(repo: sl<HomeRepository>()),
  );
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl<HomeUsecase>()));
}
