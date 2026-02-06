import 'package:yuk_baca_quran/core/network/dio_client.dart';
import 'package:yuk_baca_quran/data/model/surat_model.dart';

class HomeRepository {
  final DioClient dioClient;

  HomeRepository({required this.dioClient});

  Future<SuratModel> getSurat() async {
    final response = await dioClient.get("/surat");
    final data = SuratModel.fromJson(response);
    return data;
  }
}
