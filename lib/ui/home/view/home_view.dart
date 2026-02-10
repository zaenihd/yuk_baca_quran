import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuk_baca_quran/core/navigation/app_router.dart';
import 'package:yuk_baca_quran/core/navigation/app_routes.dart';
import 'package:yuk_baca_quran/core/navigation/navigation_service.dart';
import 'package:yuk_baca_quran/helper/widget/app_text_form_field.dart';
import 'package:yuk_baca_quran/helper/widget/app_txt.dart';
import 'package:yuk_baca_quran/ui/home/cubit/home_cubit.dart';
import 'package:yuk_baca_quran/ui/home/widget/dialog_search.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.surat != null) {
            return Padding(
              padding: .only(left: 20, right: 20, top: 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Txt(
                        "Quran qu",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) =>
                                QuranSurahDialog(surat: state.surat!),
                          );
                        },
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      padding: .zero,
                      itemBuilder: (context, index) {
                        final surat = state.surat![index];
                        return InkWell(
                          onTap: () {
                            NavigationService.pushNamed(
                              AppRoutes.detailSurat,
                              args: surat.nomor,
                            );
                          },
                          child: Container(
                            margin: .only(bottom: 10),
                            padding: .symmetric(horizontal: 15, vertical: 15),
                            width: MediaQuery.sizeOf(context).width,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Txt(
                                      "${index + 1}",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(width: 20.0),
                                    Column(
                                      mainAxisAlignment: .center,
                                      crossAxisAlignment: .start,
                                      children: [
                                        Txt(
                                          surat.namaLatin,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Txt(
                                          "${surat.arti} : ${surat.jumlahAyat} ayat",
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Txt(surat.nama, fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.errorMessage != null) {
            Center(child: Txt(state.errorMessage!));
          }
          return SizedBox();
        },
      ),
    );
  }
}
