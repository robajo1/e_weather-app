import 'package:location/location.dart';

Location location = new Location();

bool? _serviceEnabled;
PermissionStatus? _permissionGranted;
LocationData? Data;

// Check if location service is enabled
Future<void> service() async {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled!) {
    return;
  }
  await permissionGranted();
}

// Check permission with updated logic
Future<bool> permissionGranted() async {
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.granted) {
    return true;
  }

  // Request permission if not granted
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

// Get location data
Future<void> locationData() async {
  Data = await location.getLocation();
}
