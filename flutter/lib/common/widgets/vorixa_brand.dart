import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hbb/common.dart';
import 'package:flutter_hbb/consts.dart';
import 'package:flutter_hbb/mobile/pages/home_page.dart';
import 'package:flutter_hbb/models/platform_model.dart';
import 'package:flutter_hbb/common/widgets/vorixa_credits.dart';

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
        color: dark ? const Color(0x14FFFFFF) : const Color(0xFFF3F7FC),
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


class VorixaColors {
  static const Color bg0 = Color(0xFF070914);
  static const Color bg1 = Color(0xFF0E1230);
  static const Color accent = Color(0xFF4E5BFF);
  static const Color accentLight = Color(0xFF8E98FF);
  static const Color orange = Color(0xFFFF8A00);
}

/// Deep navy background with soft blue glows.
class VorixaBackdrop extends StatelessWidget {
  const VorixaBackdrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [VorixaColors.bg0, VorixaColors.bg1, VorixaColors.bg0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -120,
            top: 140,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x334E5BFF), Color(0x004E5BFF)],
                ),
              ),
            ),
          ),
          Positioned(
            right: -140,
            top: 360,
            child: Container(
              width: 360,
              height: 360,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x222286E2), Color(0x002286E2)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Frosted-glass card with a blue glow.
class VorixaGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const VorixaGlassCard(
      {Key? key,
      required this.child,
      this.padding = const EdgeInsets.fromLTRB(22, 26, 22, 24)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
              color: Color(0x554E5BFF), blurRadius: 40, spreadRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: const Color(0x26FFFFFF),
              border: Border.all(color: const Color(0x808E98FF), width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Top bar: VORIXA lockup | Powered by Jafam, language + settings buttons.
class VorixaTopBar extends StatelessWidget {
  final VoidCallback? onSettings;
  const VorixaTopBar({Key? key, this.onSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A0B10),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 8, 12),
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset('assets/vorixa_fox.png',
                          height: 56, fit: BoxFit.contain),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('VORIXA',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 1.05,
                                  letterSpacing: 1)),
                          Text('REMOTE',
                              style: TextStyle(
                                  color: VorixaColors.orange,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: 6)),
                        ],
                      ),
                      const SizedBox(width: 18),
                      Container(width: 1, height: 52, color: Colors.white24),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Powered by',
                              style: TextStyle(
                                  color: Color(0xFFD7DBEA), fontSize: 15)),
                          const SizedBox(height: 4),
                          Image.asset('assets/jafam_logo.png',
                              height: 44, fit: BoxFit.contain),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const VorixaLanguageButton(color: Color(0xFFB8C0D8)),
              if (onSettings != null)
                IconButton(
                  onPressed: onSettings,
                  icon: const Icon(Icons.settings_outlined,
                      color: Color(0xFFB8C0D8), size: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Big "Your ID" title with the formatted ID underneath (tap to copy).
class VorixaMyId extends StatefulWidget {
  const VorixaMyId({Key? key}) : super(key: key);

  @override
  State<VorixaMyId> createState() => _VorixaMyIdState();
}

class _VorixaMyIdState extends State<VorixaMyId> {
  String _id = '';
  Timer? _timer;

  Future<void> _load() async {
    final v = await bind.mainGetMyId();
    if (mounted && v != _id) setState(() => _id = v);
  }

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _load());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _pretty {
    final d = _id.replaceAll(' ', '');
    if (d.isEmpty) return '···  ···  ···';
    final parts = <String>[];
    for (var i = 0; i < d.length; i += 3) {
      parts.add(d.substring(i, i + 3 > d.length ? d.length : i + 3));
    }
    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            translate('vorixa_your_id'),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (_id.isNotEmpty) {
              Clipboard.setData(ClipboardData(text: _id));
              showToast(translate('Copied'));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _pretty,
                style: const TextStyle(
                    color: VorixaColors.accentLight,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Pill-shaped primary button with a glow.
class VorixaConnectButton extends StatelessWidget {
  final VoidCallback onTap;
  const VorixaConnectButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          gradient: const LinearGradient(
              colors: [Color(0xFF5B68FF), Color(0xFF4650F0)]),
          boxShadow: const [
            BoxShadow(
                color: Color(0x884E5BFF), blurRadius: 22, offset: Offset(0, 8)),
          ],
        ),
        child: Text(
          translate('Connect'),
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}


/// Footer link "Developed by Hamzeh Youssefi" -> opens creator / sponsor card.
class VorixaCreditLink extends StatelessWidget {
  const VorixaCreditLink({Key? key}) : super(key: key);

  void _open() {
    gFFI.dialogManager.show((setState, close, context) {
      return CustomAlertDialog(
        title: const Text('VORIXA Remote'),
        content: SizedBox(
          width: 360,
          child: SingleChildScrollView(child: VorixaCreditsCard()),
        ),
        actions: [dialogButton('Close', onPressed: close)],
        onCancel: close,
      );
    }, clickMaskDismiss: true, backDismiss: true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _open,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_rounded,
                size: 14, color: VorixaColors.orange),
            const SizedBox(width: 6),
            Text(
              translate('vorixa_credit'),
              style: const TextStyle(
                  color: VorixaColors.accentLight,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
