import 'package:cab_rider/brand_colors.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(48.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              status,
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
