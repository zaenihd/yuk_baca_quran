import 'package:meta/meta.dart';
import 'dart:convert';

DetailSurahModel detailSurahModelFromJson(String str) => DetailSurahModel.fromJson(json.decode(str));

String detailSurahModelToJson(DetailSurahModel data) => json.encode(data.toJson());

class DetailSurahModel {
  final int code;
  final String message;
  final DataSurat data;

  DetailSurahModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailSurahModel.fromJson(Map<String, dynamic>? json) => DetailSurahModel(
    code: json?["code"] ?? 0,
    message: json?["message"] ?? "",
    data: DataSurat.fromJson(json?["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class DataSurat {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Ayat> ayat;
  final SuratSenya? suratSelanjutnya; // Dibuat nullable karena Surah terakhir tidak punya next
  final SuratSenya? suratSebelumnya; // Dibuat nullable karena Surah pertama tidak punya prev

  DataSurat({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  factory DataSurat.fromJson(Map<String, dynamic>? json) => DataSurat(
    nomor: json?["nomor"] ?? 0,
    nama: json?["nama"] ?? "",
    namaLatin: json?["namaLatin"] ?? "",
    jumlahAyat: json?["jumlahAyat"] ?? 0,
    tempatTurun: json?["tempatTurun"] ?? "",
    arti: json?["arti"] ?? "",
    deskripsi: json?["deskripsi"] ?? "",
    audioFull: Map.from(json?["audioFull"] ?? {}).map((k, v) => MapEntry<String, String>(k, v ?? "")),
    ayat: json?["ayat"] == null 
        ? [] 
        : List<Ayat>.from(json!["ayat"].map((x) => Ayat.fromJson(x))),
    suratSelanjutnya: json?["suratSelanjutnya"] == null || json?["suratSelanjutnya"] == false
        ? null 
        : SuratSenya.fromJson(json!["suratSelanjutnya"]),
    suratSebelumnya: json?["suratSebelumnya"] == null || json?["suratSebelumnya"] == false
        ? null 
        : SuratSenya.fromJson(json!["suratSebelumnya"]),
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
    "tempatTurun": tempatTurun,
    "arti": arti,
    "deskripsi": deskripsi,
    "audioFull": Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "ayat": List<dynamic>.from(ayat.map((x) => x.toJson())),
    "suratSelanjutnya": suratSelanjutnya?.toJson(),
    "suratSebelumnya": suratSebelumnya?.toJson(),
  };
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic>? json) => Ayat(
    nomorAyat: json?["nomorAyat"] ?? 0,
    teksArab: json?["teksArab"] ?? "",
    teksLatin: json?["teksLatin"] ?? "",
    teksIndonesia: json?["teksIndonesia"] ?? "",
    audio: Map.from(json?["audio"] ?? {}).map((k, v) => MapEntry<String, String>(k, v ?? "")),
  );

  Map<String, dynamic> toJson() => {
    "nomorAyat": nomorAyat,
    "teksArab": teksArab,
    "teksLatin": teksLatin,
    "teksIndonesia": teksIndonesia,
    "audio": Map.from(audio).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class SuratSenya {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratSenya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSenya.fromJson(Map<String, dynamic>? json) => SuratSenya(
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