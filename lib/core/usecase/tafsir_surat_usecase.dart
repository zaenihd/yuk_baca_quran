import 'package:yuk_baca_quran/data/model/tafsir_surat_model.dart';
import 'package:yuk_baca_quran/data/repository/tafsir_repository.dart';

class TafsirSuratUsecase {
  final TafsirRepository repo;

  TafsirSuratUsecase({required this.repo});

  Future<TafsirSurahModel> fetchTafsir (int idSurat)async{
    final req = await repo.getTafsir(idSurat);
    return req;
  }
}