import 'dart:convert';

TafsirSurahModel tafsirSurahModelFromJson(String str) =>
    TafsirSurahModel.fromJson(json.decode(str));

String tafsirSurahModelToJson(TafsirSurahModel data) =>
    json.encode(data.toJson());

class TafsirSurahModel {
  final int code;
  final String message;
  final DataTafsir?
  data; // Dibuat nullable jika seandainya data tidak ditemukan

  TafsirSurahModel({required this.code, required this.message, this.data});

  factory TafsirSurahModel.fromJson(Map<String, dynamic>? json) =>
      TafsirSurahModel(
        code: json?["code"] ?? 0,
        message: json?["message"] ?? "",
        data: json?["data"] == null ? null : DataTafsir.fromJson(json!["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataTafsir {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Tafsir> tafsir;
  final SuratSelanjutnya?
  suratSelanjutnya; // Dibuat nullable karena tidak semua surat punya 'selanjutnya'
  final dynamic
  suratSebelumnya; // Menggunakan dynamic karena bisa bool atau object tergantung API

  DataTafsir({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.tafsir,
    this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory DataTafsir.fromJson(Map<String, dynamic>? json) => DataTafsir(
    nomor: json?["nomor"] ?? 0,
    nama: json?["nama"] ?? "",
    namaLatin: json?["namaLatin"] ?? "",
    jumlahAyat: json?["jumlahAyat"] ?? 0,
    tempatTurun: json?["tempatTurun"] ?? "",
    arti: json?["arti"] ?? "",
    deskripsi: json?["deskripsi"] ?? "",
    audioFull: json?["audioFull"] == null
        ? {}
        : Map.from(
            json!["audioFull"],
          ).map((k, v) => MapEntry<String, String>(k, v.toString())),
    tafsir: json?["tafsir"] == null
        ? []
        : List<Tafsir>.from(json!["tafsir"].map((x) => Tafsir.fromJson(x))),
    suratSelanjutnya:
        json?["suratSelanjutnya"] == null || json?["suratSelanjutnya"] == false
        ? null
        : SuratSelanjutnya.fromJson(json!["suratSelanjutnya"]),
    suratSebelumnya: json?["suratSebelumnya"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
    "tempatTurun": tempatTurun,
    "arti": arti,
    "deskripsi": deskripsi,
    "audioFull": Map.from(
      audioFull,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "tafsir": List<dynamic>.from(tafsir.map((x) => x.toJson())),
    "suratSelanjutnya": suratSelanjutnya?.toJson(),
    "suratSebelumnya": suratSebelumnya,
  };
}

class SuratSelanjutnya {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratSelanjutnya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSelanjutnya.fromJson(Map<String, dynamic>? json) =>
      SuratSelanjutnya(
        nomor: json?["nomor"] ?? 0,
        nama: json?["nama"] ?? "",
        namaLatin: json?["namaLatin"] ?? "",
        jumlahAyat: json?["jumlahAyat"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
  };
}

class Tafsir {
  final int ayat;
  final String teks;

  Tafsir({required this.ayat, required this.teks});

  factory Tafsir.fromJson(Map<String, dynamic>? json) =>
      Tafsir(ayat: json?["ayat"] ?? 0, teks: json?["teks"] ?? "");

  Map<String, dynamic> toJson() => {"ayat": ayat, "teks": teks};
}
