// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_cubit.dart';

class DetailState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final DataSurat? dataSurat;
  const DetailState({
    this.isLoading = false,
    this.errorMessage,
    this.dataSurat,
  });

  @override
  List<Object?> get props => [dataSurat, isLoading, errorMessage];

  DetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    DataSurat? dataSurat,
  }) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      dataSurat: dataSurat ?? this.dataSurat,
    );
  }
}
