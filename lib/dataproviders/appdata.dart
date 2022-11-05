import 'package:cab_rider/helpers/helpermethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAddress = Address(
      placeId: 'home',
      latitude: 0,
      longitude: 0,
      placeName: 'Place Name',
      placeFormattedAddress: 'placeFormattedAddress');
  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
