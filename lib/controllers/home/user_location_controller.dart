import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../vaahextendflutter/helpers/alerts.dart';
import '../../views/pages/permission_denied.dart';

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
      await Permission.location.onDeniedCallback(() {
        Alerts.showErrorToast!(content: 'Location permissions are disabled!');
      }).onGrantedCallback(() {
        Alerts.showSuccessToast!(content: 'Location permissions are enabled!');
      }).onPermanentlyDeniedCallback(() {
        Get.to(() => const PermissionDeniedPage());
      }).onRestrictedCallback(() {
        Alerts.showErrorToast!(content: 'Location permissions are denied!');
      }).request();
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled &&
          (await Permission.location.status.isGranted ||
              await Permission.location.status.isLimited)) {
        _position = await Geolocator.getCurrentPosition();
      }
      if (_position != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _position!.latitude, _position!.longitude);
        Placemark myLocationInfo = placemarks[2];
        currentLocation.value =
            '${myLocationInfo.name}, ${myLocationInfo.subLocality}, ${myLocationInfo.administrativeArea}';
      }
    } catch (e) {
      Alerts.showErrorToast!(content: 'Unable to get Location!');
    }
  }
}
