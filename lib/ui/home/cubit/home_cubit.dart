// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:yuk_baca_quran/core/usecase/home_usecase.dart';
import 'package:yuk_baca_quran/data/model/surat_model.dart';
import 'package:yuk_baca_quran/helper/widget/app_notifier.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase usecase;
  HomeCubit(this.usecase) : super(HomeState());

  Future<dynamic> fetchSurat() async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<SuratData> response = await usecase.fetchListSurat();

      emit(state.copyWith(isLoading: false, surat: response));
      return response;
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      AppNotifier.showError(e.toString());
    }
  }
}
