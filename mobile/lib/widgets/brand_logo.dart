import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.showName = true,
    this.iconSize = 72,
    this.textSize = 40,
    this.center = true,
    this.dark = true,
  });

  final bool showName;
  final double iconSize;
  final double textSize;
  final bool center;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final labelColor = dark ? Colors.white : const Color(0xFF222B3A);

    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(iconSize * 0.26),
            color: const Color(0xFF0E1633),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x3342B9FF), blurRadius: 16, offset: Offset(0, 8)),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(iconSize * 0.12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(iconSize * 0.18),
              child: Image.asset('assets/logo/madu_logo.png', fit: BoxFit.cover),
            ),
          ),
        ),
        if (showName) ...<Widget>[
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(text: 'Madu ', style: TextStyle(color: labelColor, fontWeight: FontWeight.w400, letterSpacing: 0.2)),
                const TextSpan(text: 'Gate', style: TextStyle(color: AppPalette.brandSecondary, fontWeight: FontWeight.w700, letterSpacing: 0.15)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
