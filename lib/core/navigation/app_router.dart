import 'package:flutter/material.dart';
import 'package:yuk_baca_quran/ui/detail/view/detail_surat_view.dart';
import 'package:yuk_baca_quran/ui/home/view/home_view.dart';
import 'package:yuk_baca_quran/ui/tafsir/view/tafsir_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case AppRoutes.detailSurat:
        return MaterialPageRoute(
          builder: (_) =>
              DetailSuratView(nomerSurat: settings.arguments as int),
        );
      case AppRoutes.tafsir:
        return MaterialPageRoute(
          builder: (_) => TafsirView(idSurah: settings.arguments as int),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
