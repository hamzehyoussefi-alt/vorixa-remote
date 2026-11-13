import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Brand and credits block shown on the About screens (desktop and mobile).
/// Contains: the VORIXA Remote lockup (with sponsor), the creator, the
/// project description and the open-source (AGPL-3.0) notice.
class VorixaCreditsCard extends StatelessWidget {
  const VorixaCreditsCard({Key? key}) : super(key: key);

  static const Color _blue = Color(0xFF2286E2);
  static const Color _orange = Color(0xFFFF8A00);
  static const String _sourceUrl =
      'https://github.com/hamzehyoussefi-alt/vorixa-remote';

  Widget _link(String text, String url, TextStyle style) {
    return InkWell(
      onTap: () => launchUrlString(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = dark ? Colors.white : const Color(0xFF14161A);
    final Color subColor = dark ? Colors.white70 : Colors.black54;
    final TextStyle linkStyle = const TextStyle(
      color: _blue,
      fontSize: 13,
      decoration: TextDecoration.underline,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1B1E24) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: dark ? Colors.white12 : Colors.black12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1) Product lockup + sponsor (white plate so it reads in dark mode)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Image.asset(
              'assets/vorixa_logo_g.png',
              height: 76,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          // 2) Creator hero
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/vorixa_creator.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0xC7000000)],
                          stops: [0.45, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hamzeh Youssefi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'حمزه یوسفی',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Developer & Customizer',
                          style: TextStyle(
                            color: _orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 3) Slogan + description
          const Text(
            'نوآوری VORIXA، زیرساخت جافام؛ آینده مدیریت از راه دور.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _orange,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'VORIXA Remote، ابزار ارتباطی و کنترل از راه دور برند VORIXA است و بخشی از اکوسیستم نرم‌افزاری سامانه سلامت جافام (jafam.ir) به شمار می‌رود. ما با تکیه بر فناوری روز و زیرساخت پایدار جافام، اتصال از راه دور را سریع و امن در اختیار شما می‌گذاریم.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(color: subColor, fontSize: 13, height: 1.8),
          ),
          const SizedBox(height: 8),
          Text(
            'A VORIXA product, part of the Jafam software ecosystem.',
            textAlign: TextAlign.center,
            style: TextStyle(color: subColor, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 10),
          Text(
            'by Jafam',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          _link('jafam.ir', 'https://jafam.ir', linkStyle),
          const Divider(height: 20),
          // 4) Open-source notice (AGPL-3.0)
          Text(
            'Built on the open-source RustDesk project (AGPL-3.0).',
            textAlign: TextAlign.center,
            style: TextStyle(color: subColor, fontSize: 12, height: 1.5),
          ),
          Text(
            'این برنامه بر پایه پروژه متن‌باز RustDesk ساخته شده است.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(color: subColor, fontSize: 12, height: 1.6),
          ),
          _link('Source code', _sourceUrl, linkStyle),
        ],
      ),
    );
  }
}
