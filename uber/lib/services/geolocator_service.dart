import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Placemark> getFirstByDescription(String description) async {
    List<Placemark> addressList = await getByDescription(description);
    return (addressList != null && addressList.length > 0)
        ? addressList[0]
        : null;
  }

  Future<List<Placemark>> getByDescription(String description) async {
    return (description.isNotEmpty)
        ? await Geolocator().placemarkFromAddress(description)
        : [];
  }

  listenerPosition(Function callback) async {
    await Geolocator()
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.high, distanceFilter: 10))
        .listen((Position position) {
      callback(position);
    });
  }

  getLastKnownPosition() async {
    return await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  setLastKnownPositionAndlistener(Function callback) async {
    Position position = await getLastKnownPosition();
    callback(position);
    await Geolocator()
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.high, distanceFilter: 10))
        .listen((Position position) {
      callback(position);
    });
  }
}
