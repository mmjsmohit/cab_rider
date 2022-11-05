import 'package:cab_rider/datamodels/address.dart';
import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = '';
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    placeAddress = placemarks[0].toString();
    placeAddress =
        "${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    Address pickupAddress = Address(
        placeId: 'home',
        latitude: position.latitude,
        longitude: position.longitude,
        placeName: placemarks[0].name.toString(),
        placeFormattedAddress: placeAddress);
    Provider.of<AppData>(context, listen: false)
        .updatePickupAddress(pickupAddress);
    return placeAddress;
  }
}
