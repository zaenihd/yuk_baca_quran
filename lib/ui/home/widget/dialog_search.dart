import 'package:flutter/material.dart';
import 'package:yuk_baca_quran/core/navigation/app_routes.dart';
import 'package:yuk_baca_quran/core/navigation/navigation_service.dart';
import 'package:yuk_baca_quran/data/model/surat_model.dart';
import 'package:yuk_baca_quran/helper/widget/app_txt.dart';

class QuranSurahDialog extends StatefulWidget {
  final List<SuratData> surat;
  const QuranSurahDialog({super.key, required this.surat});

  @override
  State<QuranSurahDialog> createState() => _QuranSurahDialogState();
}

class _QuranSurahDialogState extends State<QuranSurahDialog> {
  final TextEditingController _searchController = TextEditingController();

  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filteredSurah = widget.surat
        .where((s) => s.namaLatin.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 420,
        height: 520,
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _query = value);
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  isDense: true,
                ),
              ),
            ),

            // 📖 Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quran Surah",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 8),
            // 📜 List Surah
            Expanded(
              child: ListView.builder(
                itemCount: filteredSurah.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredSurah[index].namaLatin),
                    subtitle: Txt("${filteredSurah[index].arti} - ${filteredSurah[index].jumlahAyat} ayat"),
                    onTap: () {
                      NavigationService.pushNamed(
                        AppRoutes.detailSurat,
                        args: filteredSurah[index].nomor,
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
