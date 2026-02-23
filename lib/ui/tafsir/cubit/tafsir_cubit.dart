import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuk_baca_quran/core/usecase/tafsir_surat_usecase.dart';
import 'package:yuk_baca_quran/data/model/tafsir_surat_model.dart';
import 'package:yuk_baca_quran/helper/widget/app_notifier.dart';

part 'tafsir_state.dart';

class TafsirCubit extends Cubit<TafsirState> {
  final TafsirSuratUsecase usecase;
  TafsirCubit(this.usecase) : super(TafsirState());

  Future<dynamic> fetchTafsir(int idSurat) async {
    emit(state.copyWith(isLoading: true));
    try {
      final TafsirSurahModel response = await usecase.fetchTafsir(idSurat);
      final DataTafsir data = response.data!;

      emit(state.copyWith(isLoading: false, tafsir: data));
      return response;
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      AppNotifier.showError(e.toString());
    }
  }
}
