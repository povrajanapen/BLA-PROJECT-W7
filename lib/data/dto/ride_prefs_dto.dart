import 'package:week_3_blabla_project/data/dto/locations_dto.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  static Map<String, dynamic> toJson(RidePreference model) {
    return {
      'departure': LocationDto.toJson(model.departure),
      'arrival': LocationDto.toJson(model.arrival),
      'departureDate': model.departureDate.toIso8601String(),
      'requestedSeats': model.requestedSeats,
    };
  }

static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: LocationDto.fromJson(json['departure']),
      arrival: LocationDto.fromJson(json['arrival']),
      departureDate: DateTime.parse(json['departureDate']),
      requestedSeats: json['requestedSeats'],
    );
  }
}

