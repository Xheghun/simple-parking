enum LocationErrorType { DENIED, NOT_ENABLED }

class LocationError implements Exception {
  String message;
  LocationErrorType type;

  LocationError(this.type, {this.message});
}
