import 'dart:convert';

import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/datamodels/prediction.dart';
import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:cab_rider/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cab_rider/globalvariables.dart';
import 'package:http/http.dart' as http;

import '../widgets/PredictionTile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickupController = TextEditingController();
  var destinationControlller = TextEditingController();
  var focusDestination = FocusNode();

  bool focused = false;
  void setFocus() {
    if (!focused) {
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

  List<Prediction> destinationPredictionList = [];

  void searchPlace(String placeName) async {
    String key = mapKey;
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${placeName}&key=${key}&sessiontoken=123254251&components=country:in';
    if (placeName.length > 1) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var predictionsResultJson = jsonDecode(response.body);
        List<dynamic> predictions = predictionsResultJson['predictions'];
        var thisList =
            (predictions as List).map((e) => Prediction.fromJson(e)).toList();
        setState(() {
          destinationPredictionList = thisList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    String address =
        Provider.of<AppData>(context).pickupAddress.placeFormattedAddress ??
            " ";
    pickupController.text = address;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 210,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7))
              ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Center(
                        child: Text(
                          'Set Destination',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'images/pickicon.png',
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              controller: pickupController,
                              decoration: const InputDecoration(
                                hintText: 'Pickup Location',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'images/desticon.png',
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              onChanged: (value) {
                                searchPlace(value);
                              },
                              focusNode: focusDestination,
                              controller: destinationControlller,
                              decoration: const InputDecoration(
                                hintText: 'Where to?',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            (destinationPredictionList.isNotEmpty)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          prediction: destinationPredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const BrandDivider(),
                      itemCount: destinationPredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 18),
                    child: const Text('No Results Match your search Query!'),
                  ),
          ],
        ),
      ),
    );
  }
}
