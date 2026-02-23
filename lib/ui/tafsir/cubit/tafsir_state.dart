// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tafsir_cubit.dart';

class TafsirState extends Equatable {
  TafsirState({this.isLoading = false, this.tafsir, this.errorMessage});

  final bool isLoading;
  final DataTafsir? tafsir;
  final String? errorMessage;

  @override
  List<Object?> get props => [isLoading, tafsir, errorMessage];

  TafsirState copyWith({
    bool? isLoading,
    DataTafsir? tafsir,
    String? errorMessage,
  }) {
    return TafsirState(
      isLoading: isLoading ?? this.isLoading,
      tafsir: tafsir ?? this.tafsir,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
