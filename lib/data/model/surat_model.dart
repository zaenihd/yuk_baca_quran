import 'dart:convert';

SuratModel suratModelFromJson(String str) => SuratModel.fromJson(json.decode(str));

String suratModelToJson(SuratModel data) => json.encode(data.toJson());

class SuratModel {
    final int code;
    final String message;
    final List<SuratData> data;

    SuratModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory SuratModel.fromJson(Map<String, dynamic> json) => SuratModel(
        // Memberikan default 0 jika code null
        code: json["code"] ?? 0, 
        // Memberikan string kosong jika message null
        message: json["message"] ?? "", 
        // Memberikan list kosong jika data null
        data: json["data"] == null 
            ? [] 
            : List<SuratData>.from(json["data"].map((x) => SuratData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SuratData {
    final int nomor;
    final String nama;
    final String namaLatin;
    final int jumlahAyat;
    final TempatTurun tempatTurun;
    final String arti;
    final String deskripsi;
    final Map<String, String> audioFull;

    SuratData({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audioFull,
    });

    factory SuratData.fromJson(Map<String, dynamic> json) => SuratData(
        nomor: json["nomor"] ?? 0,
        nama: json["nama"] ?? "",
        namaLatin: json["namaLatin"] ?? "",
        jumlahAyat: json["jumlahAyat"] ?? 0,
        // Cek apakah key ada di enum map, jika tidak default ke MEKAH
        tempatTurun: tempatTurunValues.map[json["tempatTurun"]] ?? TempatTurun.MEKAH,
        arti: json["arti"] ?? "",
        deskripsi: json["deskripsi"] ?? "",
        // Memberikan map kosong jika audioFull null
        audioFull: json["audioFull"] == null 
            ? {} 
            : Map.from(json["audioFull"]).map((k, v) => MapEntry<String, String>(k, v.toString())),
    );

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues = EnumValues({
    "Madinah": TempatTurun.MADINAH,
    "Mekah": TempatTurun.MEKAH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}