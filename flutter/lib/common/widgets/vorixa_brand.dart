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
  final Color color;
  const VorixaLanguageButton({Key? key, this.color = const Color(0xFF2286E2)})
      : super(key: key);

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
      icon: Icon(Icons.language_rounded, size: 24, color: color),
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


/// Top banner of the redesigned home screen.
class VorixaHero extends StatelessWidget {
  const VorixaHero({Key? key}) : super(key: key);

  static const Color _orange = Color(0xFFFF8A00);

  static Widget _circle(double d, int argb) => Container(
        width: d,
        height: d,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(argb)),
      );

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 124,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF071B38), Color(0xFF0E4A8F), Color(0xFF2286E2)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(right: -40, top: -60, child: _circle(220, 0x14FFFFFF)),
            Positioned(right: 110, bottom: -90, child: _circle(160, 0x10FFFFFF)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55000000),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset('assets/icon.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'VORIXA Remote',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(width: 22, height: 2, color: _orange),
                            const SizedBox(width: 8),
                            const Text(
                              'by Jafam',
                              style: TextStyle(
                                color: Color(0xFFFFB84D),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'اتصال از راه دور، سریع و امن',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VorixaLanguageButton(color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// First launch: ask for the language once, then keep it everywhere
/// (including the install page and the installed app).
void vorixaMaybeShowLanguagePicker() {
  if (bind.mainGetLocalOption(key: 'vorixa-lang-chosen') == 'Y') return;
  gFFI.dialogManager.show((setState, close, context) {
    Future<void> pick(String code) async {
      await bind.mainSetLocalOption(key: 'vorixa-lang-chosen', value: 'Y');
      await bind.mainSetLocalOption(key: kCommConfKeyLang, value: code);
      close();
      if (isAndroid || isIOS) {
        HomePage.homeKey.currentState?.refreshPages();
        return;
      }
      reloadAllWindows();
      bind.mainChangeLanguage(lang: code);
    }

    return CustomAlertDialog(
      title: Column(
        children: const [
          Text(
            'VORIXA Remote',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 6),
          Text(
            'زبان خود را انتخاب کنید  ·  Choose your language',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
      content: SizedBox(
        width: 330,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final l in VorixaLanguageButton._langs)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => pick(l[0]),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0x552286E2)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l[1],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 14, color: Color(0xFF2286E2)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: const [],
    );
  }, clickMaskDismiss: false, backDismiss: false);
}
