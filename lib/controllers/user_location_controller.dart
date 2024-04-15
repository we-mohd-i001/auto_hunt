import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../vaahextendflutter/helpers/alerts.dart';

class UserLocationController extends GetxController {
  RxString currentLocation = 'Location Unavailable'.obs;
  Position? _position;
  @override
  void onInit() {
    super.onInit();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      await Permission.location
          .onDeniedCallback(() {
            Alerts.showErrorToast!(
                content: 'Location permissions are disabled!');
          })
          .onGrantedCallback(() {})
          .onPermanentlyDeniedCallback(() {
            // Your code
          })
          .onRestrictedCallback(() {
            Alerts.showErrorToast!(content: 'Location permissions are denied!');
          })
          .onLimitedCallback(() {
            // Your code
          })
          .onProvisionalCallback(() {
            // Your code
          })
          .request();
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled &&
          (await Permission.location.status.isGranted ||
              await Permission.location.status.isLimited)) {
        _position = await Geolocator.getCurrentPosition();
        print('${_position!.latitude} latt');
      }
      if (_position != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _position!.latitude, _position!.longitude);
        print(placemarks);
        Placemark myLocationInfo = placemarks[2];
        currentLocation.value =
            '${myLocationInfo.name}, ${myLocationInfo.subLocality}, ${myLocationInfo.administrativeArea}';
      }
      print(currentLocation);
    } catch (e) {
      Alerts.showErrorToast!(content: 'Unable to get Location!');
    }
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    _determinePosition();
    super.update(ids, condition);
  }
}
