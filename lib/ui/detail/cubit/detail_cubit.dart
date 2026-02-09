import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuk_baca_quran/core/usecase/detail_surat_usecase.dart';
import 'package:yuk_baca_quran/data/model/detail_surat_model.dart';
import 'package:yuk_baca_quran/helper/widget/app_notifier.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailSuratUsecase usecase;
  DetailCubit(this.usecase) : super(DetailState());

  Future<dynamic> getDetailSurat(int nomerSurat) async {
    emit(state.copyWith(isLoading: true));
    try {
      DataSurat responseData = await usecase.fetchDetailSurat(nomerSurat);
      print("masuk sini ya");
      emit(state.copyWith(isLoading: false, dataSurat: responseData));
    } catch (e) {
      print("masuk sini ya error");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      AppNotifier.showError(e.toString());
    }
  }
}
