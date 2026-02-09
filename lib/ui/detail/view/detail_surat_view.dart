import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuk_baca_quran/core/di_getit/service_locator.dart';
import 'package:yuk_baca_quran/helper/widget/app_txt.dart';
import 'package:yuk_baca_quran/ui/detail/cubit/detail_cubit.dart';

class DetailSuratView extends StatelessWidget {
  final int nomerSurat;
  const DetailSuratView({super.key, required this.nomerSurat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetailCubit>()..getDetailSurat(nomerSurat),
      child: Scaffold(
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.dataSurat != null) {
              return ListView.builder(
                padding: .only(left: 20, right: 20, bottom: 5, top: 50),
                itemCount: state.dataSurat!.ayat.length,
                itemBuilder: (context, index) {
                  final dataSurat = state.dataSurat!.ayat[index];
                  return Column(
                    crossAxisAlignment: .end,
                    children: [
                      Txt(dataSurat.teksArab, fontWeight: FontWeight.bold, fontSize: 18,),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Txt(dataSurat.teksLatin, color: Colors.green,),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Txt(dataSurat.teksIndonesia),
                          ],
                        ),
                      ),
                      Divider(thickness: 1,)
                    ],
                  );
                },
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
}
