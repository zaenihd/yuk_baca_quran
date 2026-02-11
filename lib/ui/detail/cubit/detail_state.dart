// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_cubit.dart';

class DetailState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final DataSurat? dataSurat;
  final bool isPlaying;
  final bool showMiniPlayer;
  final int currentIndex;
  final bool isPause;
  const DetailState({
    this.isLoading = false,
    this.errorMessage,
    this.dataSurat,
    this.isPlaying = false,
    this.showMiniPlayer = false,
    this.currentIndex = -1,
    this.isPause = false,
  });

  @override
  List<Object?> get props => [
    dataSurat,
    isLoading,
    errorMessage,
    isPlaying,
    currentIndex,
    showMiniPlayer,
    isPause
  ];

  DetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    DataSurat? dataSurat,
    bool? isPlaying,
    bool? showMiniPlayer,
    int? currentIndex,
    bool? isPause,
  }) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      dataSurat: dataSurat ?? this.dataSurat,
      isPlaying: isPlaying ?? this.isPlaying,
      showMiniPlayer: showMiniPlayer ?? this.showMiniPlayer,
      currentIndex: currentIndex ?? this.currentIndex,
      isPause: isPause ?? this.isPause,
    );
  }
}
