import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:yuk_baca_quran/core/network/dio_client.dart';
import 'package:yuk_baca_quran/core/usecase/detail_surat_usecase.dart';
import 'package:yuk_baca_quran/core/usecase/home_usecase.dart';
import 'package:yuk_baca_quran/core/usecase/tafsir_surat_usecase.dart';
import 'package:yuk_baca_quran/data/repository/detail_repository.dart';
import 'package:yuk_baca_quran/data/repository/home_repository.dart';
import 'package:yuk_baca_quran/data/repository/tafsir_repository.dart';
import 'package:yuk_baca_quran/ui/detail/cubit/detail_cubit.dart';
import 'package:yuk_baca_quran/ui/home/cubit/home_cubit.dart';
import 'package:yuk_baca_quran/ui/tafsir/cubit/tafsir_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  homeInit();
  detailSuratInit();
  tafsirInit();
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

void detailSuratInit() {
  sl.registerLazySingleton<DetailRepository>(
    () => DetailRepository(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<DetailSuratUsecase>(
    () => DetailSuratUsecase(repository: sl<DetailRepository>()),
  );
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
  sl.registerFactory<DetailCubit>(
    () => DetailCubit(sl<DetailSuratUsecase>(), sl<AudioPlayer>()),
  );
}

void tafsirInit() {
  sl.registerLazySingleton<TafsirRepository>(
    () => TafsirRepository(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<TafsirSuratUsecase>(
    () => TafsirSuratUsecase(repo: sl<TafsirRepository>()),
  );
  sl.registerFactory<TafsirCubit>(() => TafsirCubit(sl<TafsirSuratUsecase>()));
}
