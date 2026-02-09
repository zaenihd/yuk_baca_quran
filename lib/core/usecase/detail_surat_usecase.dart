import 'package:yuk_baca_quran/data/model/detail_surat_model.dart';
import 'package:yuk_baca_quran/data/repository/detail_repository.dart';

class DetailSuratUsecase {
  final DetailRepository repository;

  DetailSuratUsecase({required this.repository});

  Future<DataSurat> fetchDetailSurat(int nomerSurat) async {
    return await repository.getDetailSurah(nomerSurat);
  }
}
