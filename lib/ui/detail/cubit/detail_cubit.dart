import 'dart:async'; // Tambahkan ini untuk StreamSubscription
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:yuk_baca_quran/core/usecase/detail_surat_usecase.dart';
import 'package:yuk_baca_quran/data/model/detail_surat_model.dart';
import 'package:yuk_baca_quran/helper/widget/app_notifier.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailSuratUsecase usecase;
  final AudioPlayer player;

  // Variable untuk menyimpan langganan stream player
  StreamSubscription<PlayerState>? _playerSubscription;

  DetailCubit(this.usecase, this.player) : super(const DetailState()) {
    // 1. INISIALISASI LISTENER DI SINI
    _initAudioListener();
  }

  // --- FUNGSI PENTING: MENDENGARKAN STATUS AUDIO ---
  void _initAudioListener() {
    // 2. Dengarkan perubahan status player
    player.playerStateStream.listen((playerState) {
      // Update status playing/pause ke UI
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // Update state jika status playing berubah (agar icon berubah)
      if (state.isPlaying != isPlaying) {
        emit(state.copyWith(isPlaying: isPlaying));
      }

      // 3. LOGIC PINDAH OTOMATIS
      // Jika audio selesai (completed), pindah ke ayat selanjutnya
      if (processingState == ProcessingState.completed) {
        playNextAyah();
      }
    });
  }

  Future<void> playAyah(int index) async {
    // Safety check data
    if (state.dataSurat == null) return;

    try {
      // 1. Update UI segera agar responsif (User melihat tombol berubah)
      emit(
        state.copyWith(
          currentIndex: index,
          showMiniPlayer: true,
          isPlaying: true,
          isPause: true,
        ),
      );

      final audioUrl = state.dataSurat!.ayat[index].audio['01'];

      if (audioUrl != null) {
        // HAPUS "await player.stop()" di sini.
        // setUrl akan otomatis menghentikan audio sebelumnya.
        // Menggunakan stop() manual seringkali malah memicu race condition.

        // 2. Load URL baru
        await player.setUrl(audioUrl);

        // 3. Play
        await player.play();
      } else {
        AppNotifier.showError("Audio tidak tersedia");
      }
    } catch (e) {
      // --- BAGIAN PENTING: SOLUSI ERROR ---

      // Cek apakah error disebabkan karena loading dibatalkan (user ganti ayat lain)
      if (e.toString().contains('interrupted') ||
          e.toString().contains('aborted')) {
        // Jika ya, ABAIKAN SAJA. Jangan emit error state.
        debugPrint(
          "Audio switching: Previous load interrupted (Normal behavior).",
        );
        return;
      }

      // Jika errornya ASLI (misal koneksi putus), baru kita handle
      debugPrint("Real Audio Error: $e");
      emit(state.copyWith(isPlaying: false)); // Reset tombol jadi play
      AppNotifier.showError("Gagal memutar audio: $e");
    }
  }

  // --- LOGIC PINDAH OTOMATIS ---
  void playNextAyah() {
    if (state.dataSurat == null) return;

    // Cek apakah ini ayat terakhir?
    if (state.currentIndex < state.dataSurat!.ayat.length - 1) {
      // Jika belum terakhir, mainkan index + 1
      int nextIndex = state.currentIndex + 1;
      playAyah(nextIndex);
    } else {
      // Jika sudah habis, stop dan reset status
      // Kita tidak perlu panggil player.stop() karena statusnya sudah 'completed'
      // Cukup update UI
      emit(state.copyWith(isPlaying: false));
    }
  }

  // Logic Pause / Resume
  void togglePlayPause() {
    if (player.playing) {
      emit(state.copyWith(isPause: false));
      player.pause();
    } else {
      emit(state.copyWith(isPause: true));
      player.play();
    }
  }

  void stopPlaying() {
    player.stop();
    emit(state.copyWith(showMiniPlayer: false));
  }

  Future<void> getDetailSurat(int nomerSurat) async {
    emit(state.copyWith(isLoading: true));
    try {
      DataSurat responseData = await usecase.fetchDetailSurat(nomerSurat);
      emit(state.copyWith(isLoading: false, dataSurat: responseData));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      AppNotifier.showError(e.toString());
    }
  }

  // --- PENTING: BERSIHKAN MEMORI SAAT CUBIT DITUTUP ---
  @override
  Future<void> close() {
    _playerSubscription?.cancel(); // Matikan listener
    player.stop(); // Stop audio (opsional, tergantung UX yang dimau)
    // player.dispose(); // HATI-HATI: Jika player di-inject dari luar (Dependency Injection), jangan dispose di sini.
    return super.close();
  }
}
