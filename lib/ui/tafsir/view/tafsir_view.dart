import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuk_baca_quran/core/di_getit/service_locator.dart';
import 'package:yuk_baca_quran/helper/widget/app_txt.dart';
import 'package:yuk_baca_quran/ui/tafsir/cubit/tafsir_cubit.dart';

class TafsirView extends StatelessWidget {
  const TafsirView({super.key, required this.idSurah});
  final int idSurah;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TafsirCubit>()..fetchTafsir(idSurah),
      child: Scaffold(
        appBar: AppBar(title: Text("data")),

        body: BlocBuilder<TafsirCubit, TafsirState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.tafsir != null) {
              return Column(children: [
                Txt(state.tafsir!.tafsir[0].teks)
              ],);
            }
            if (state.errorMessage != null) {
              return Center(child: Txt(state.errorMessage!));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
