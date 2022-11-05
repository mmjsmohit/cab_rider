import 'package:flutter/material.dart';

import '../brand_colors.dart';
import '../datamodels/prediction.dart';

class PredictionTile extends StatelessWidget {
  const PredictionTile({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: BrandColors.colorDimText,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prediction.mainText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      prediction.secondaryText,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12, color: BrandColors.colorDimText),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
