import 'package:yuk_baca_quran/core/network/dio_client.dart';
import 'package:yuk_baca_quran/data/model/detail_surat_model.dart';

class DetailRepository {
  final DioClient dioClient;

  DetailRepository({required this.dioClient});

  Future<DataSurat> getDetailSurah(int nomerSurah) async {
    final response = await dioClient.get("/surat/$nomerSurah");
    final data = DetailSurahModel.fromJson(response);
    return data.data;
  }
}
