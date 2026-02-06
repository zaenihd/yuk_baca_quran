import 'package:yuk_baca_quran/data/model/surat_model.dart';
import 'package:yuk_baca_quran/data/repository/home_repository.dart';

class HomeUsecase {
  final HomeRepository repo;

  HomeUsecase({required this.repo});

  Future<List<SuratData>> fetchListSurat() async {
    final response = await repo.getSurat();
    return response.data;
  }
}
