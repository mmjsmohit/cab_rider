import 'package:flutter/material.dart';

import '../brand_colors.dart';

class TaxiButton extends StatelessWidget {
  const TaxiButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(color),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: onPressed,
      // color: BrandColors.colorGreen,
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'Brand-Bold'),
          ),
        ),
      ),
    );
  }
}
