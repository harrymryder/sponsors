import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({
    required this.onTap,
    required this.expanded,
    Key? key,
  }) : super(key: key);

  final Function onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: smallShadow,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          expanded ? 'SEE LESS' : 'SEE MORE',
          style: GoogleFonts.workSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
