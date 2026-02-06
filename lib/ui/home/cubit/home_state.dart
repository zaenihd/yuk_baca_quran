// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<SuratData>? surat;
  final String? errorMessage;
  const HomeState({this.isLoading = false, this.surat, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, surat, errorMessage];

  HomeState copyWith({
    bool? isLoading,
    List<SuratData>? surat,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      surat: surat ?? this.surat,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
