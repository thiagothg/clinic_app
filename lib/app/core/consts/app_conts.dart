class ConstsApp {
  static const appName = 'Clínica Vet';
  static const versionApp = '1.0.0';
  static const apiKeyGooglePlaces = 'AIzaSyCwd4-LsXfL_2UJPGA2FlNMykjLDYvH3d8';

  static const faceUrl = 'https://facebook.com';
  static const whatsAppUrl = 'https://google.com';
  static const instagramUrl = 'https://instagram.com';

  static const playStoreUrl = '';

  static const termsOfUseLink = '';

  static const textShare = ''' ''';

}


class LocalStorageConstants {
  static const boxName = 'clinic-app';
  static const user = 'usuario';
  static const userPassword = 'userPassword';
}

class LocationModel {
  
  LocationModel({this.latitude, this.longitude});

  /// Latitude in degrees
  final double latitude;

  /// Longitude, in degrees
  final double longitude;
}