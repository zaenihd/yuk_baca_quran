import 'package:yuk_baca_quran/core/network/dio_client.dart';
import 'package:yuk_baca_quran/data/model/tafsir_surat_model.dart';

class TafsirRepository {
  final DioClient dioClient;

  TafsirRepository({required this.dioClient});

  Future<TafsirSurahModel> getTafsir(int idSurat)async{
    final request =await dioClient.get("/tafsir/$idSurat");
    final data = TafsirSurahModel.fromJson(request);
    return data;
  }
}