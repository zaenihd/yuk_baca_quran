import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuk_baca_quran/core/di_getit/service_locator.dart';
import 'package:yuk_baca_quran/helper/widget/app_txt.dart';
import 'package:yuk_baca_quran/ui/detail/cubit/detail_cubit.dart';

class DetailSuratView extends StatefulWidget {
  final int nomerSurat;
  const DetailSuratView({super.key, required this.nomerSurat});

  @override
  State<DetailSuratView> createState() => _DetailSuratViewState();
}

class _DetailSuratViewState extends State<DetailSuratView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetailCubit>()..getDetailSurat(widget.nomerSurat),
      child: Scaffold(
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.dataSurat != null) {
              return Stack(
                children: [
                  ListView.builder(
                    padding: .only(left: 20, right: 20, bottom: 70, top: 50),
                    itemCount: state.dataSurat!.ayat.length,
                    itemBuilder: (context, index) {
                      final dataSurat = state.dataSurat!.ayat[index];
                      return Row(
                        children: [
                          PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: const Color(
                              0xFF2C2C3E,
                            ), // Warna background popup gelap
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onSelected: (value) {
                              if (value == 'play') {
                                context.read<DetailCubit>().playAyah(index);
                              }
                            },
                            itemBuilder: (context) => [
                              _buildPopupItem(
                                'play',
                                Icons.play_arrow,
                                "Putar Ayat",
                              ),
                              _buildPopupItem(
                                'last_read',
                                Icons.book_outlined,
                                "Tandai Terakhir Baca",
                              ),
                              _buildPopupItem(
                                'bookmark',
                                Icons.bookmark_border,
                                "Simpan ke Bookmark",
                              ),
                              _buildPopupItem(
                                'tafsir',
                                Icons.chat_bubble_outline,
                                "Lihat Tafsir",
                              ),
                              _buildPopupItem('copy', Icons.copy, "Copy Text"),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.3,
                            child: Column(
                              crossAxisAlignment: .end,
                              children: [
                                Txt(
                                  dataSurat.teksArab,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                const SizedBox(height: 10.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      Txt(
                                        dataSurat.teksLatin,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Txt(dataSurat.teksIndonesia),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 1),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  if (state.showMiniPlayer == true)
                  _buildBottomMiniPlayer(
                    isPause: state.isPause,
                    namaSurah: state.dataSurat!.namaLatin,
                    currentIndex: state.currentIndex,
                    context: context,
                  ),
                ],
              );
            }
            if (state.errorMessage != null) {
              Center(child: Txt("${state.errorMessage}"));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(
    String value,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildBottomMiniPlayer({
    required String namaSurah,
    required int currentIndex,
    required bool isPause,
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: const Color(0xFF252535), // Warna background player
        child: Column(
          mainAxisSize: MainAxisSize.min, // Agar tingginya fit content
          children: [
            // Garis Progress Bar Tipis di Atas
            LinearProgressIndicator(
              value: 0.3, // Contoh progress 30%
              minHeight: 2,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.tealAccent.shade400,
              ),
            ),

            // Konten Player
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Icon Bulat Kiri (Nomor Surah)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.tealAccent.shade700.withOpacity(0.2),
                      border: Border.all(color: Colors.tealAccent, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        "${currentIndex + 1}",
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Info Teks (Tengah)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Putar Surah",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          namaSurah,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tombol Play/Pause
                  InkWell(
                    onTap: () {
                      context.read<DetailCubit>().togglePlayPause();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent.shade700.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPause == true ? Icons.pause : Icons.play_arrow,
                        color: Colors.tealAccent.shade100,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tombol Close (X)
                  GestureDetector(
                    onTap: () {
                      context.read<DetailCubit>().stopPlaying();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white54,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
