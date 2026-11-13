import 'package:flutter/material.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/consts.dart';
import 'package:flutter_hbb/mobile/pages/home_page.dart';
import 'package:flutter_hbb/models/platform_model.dart';

/// Brand header shown at the top of the desktop home screen (left pane).
class VorixaBrandHeader extends StatelessWidget {
  const VorixaBrandHeader({Key? key}) : super(key: key);

  static const Color _orange = Color(0xFFFF8A00);

  @override
  Widget build(BuildContext context) {
    final Color titleColor =
        Theme.of(context).textTheme.titleLarge?.color ?? Colors.black87;
    return Stack(children: [
      Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x332286E2),
                  blurRadius: 22,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Image.asset('assets/icon.png', fit: BoxFit.contain),
          ),
          const SizedBox(height: 14),
          Text(
            'VORIXA Remote',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 18, height: 2, color: _orange),
              const SizedBox(width: 8),
              Text(
                'by Jafam',
                style: TextStyle(
                  color: titleColor.withOpacity(0.65),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 18, height: 2, color: _orange),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'اتصال از راه دور، سریع و امن',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor.withOpacity(0.55),
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
      ),
      const Positioned(top: 4, right: 6, child: VorixaLanguageButton()),
    ]);
  }
}

/// Language switcher (the five supported languages). Works on the install
/// page and on the home screen; the choice is stored and kept after install.
class VorixaLanguageButton extends StatelessWidget {
  const VorixaLanguageButton({Key? key}) : super(key: key);

  static const List<List<String>> _langs = [
    ['fa', 'فارسی'],
    ['en', 'English'],
    ['ja', '日本語'],
    ['de', 'Deutsch'],
    ['ko', '한국어'],
  ];

  Future<void> _setLang(String code) async {
    await bind.mainSetLocalOption(key: kCommConfKeyLang, value: code);
    if (isAndroid || isIOS) {
      HomePage.homeKey.currentState?.refreshPages();
      return;
    }
    reloadAllWindows();
    bind.mainChangeLanguage(lang: code);
  }

  @override
  Widget build(BuildContext context) {
    final String current = bind.mainGetLocalOption(key: kCommConfKeyLang);
    return PopupMenuButton<String>(
      tooltip: 'Language',
      icon: const Icon(Icons.language_rounded, size: 22, color: Color(0xFF2286E2)),
      onSelected: _setLang,
      itemBuilder: (BuildContext c) => [
        for (final l in _langs)
          PopupMenuItem<String>(
            value: l[0],
            child: Row(children: [
              SizedBox(
                width: 22,
                child: current == l[0]
                    ? const Icon(Icons.check_rounded,
                        size: 18, color: Color(0xFF2286E2))
                    : null,
              ),
              Text(l[1]),
            ]),
          ),
      ],
    );
  }
}

/// Rounded surface used for the ID and password blocks.
class VorixaPanel extends StatelessWidget {
  final Widget child;
  const VorixaPanel({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1B1E24) : const Color(0xFFF3F7FC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: dark ? Colors.white12 : const Color(0x1F2286E2),
        ),
      ),
      child: child,
    );
  }
}
