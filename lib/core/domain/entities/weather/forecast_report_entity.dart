import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/city_entity.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_entry_entity.dart';

class ForecastReportEntity extends Equatable {
  const ForecastReportEntity({
    required this.entries,
    required this.city,
  });

  final List<ForecastEntryEntity> entries;
  final CityEntity city;

  @override
  List<Object?> get props => [entries, city];
}

// {
//     "cod": "200",
//     "message": 0,
//     "cnt": 40,
//     "list": [
//         {
//             "dt": 1747396800,
//             "main": {
//                 "temp": 18.72,
//                 "feels_like": 18.53,
//                 "temp_min": 18.72,
//                 "temp_max": 18.72,
//                 "pressure": 1024,
//                 "sea_level": 1024,
//                 "grnd_level": 933,
//                 "humidity": 72,
//                 "temp_kf": 0
//             },
//             "weather": [
//                 {
//                     "id": 801,
//                     "main": "Clouds",
//                     "description": "few clouds",
//                     "icon": "02d"
//                 }
//             ],
//             "clouds": {
//                 "all": 20
//             },
//             "wind": {
//                 "speed": 1.11,
//                 "deg": 99,
//                 "gust": 3.15
//             },
//             "visibility": 10000,
//             "pop": 0,
//             "sys": {
//                 "pod": "d"
//             },
//             "dt_txt": "2025-05-16 12:00:00"
//         }
//     ],
//     "city": {
//         "id": 3460960,
//         "name": "Itabira",
//         "coord": {
//             "lat": -19.6192,
//             "lon": -43.2269
//         },
//         "country": "BR",
//         "population": 99496,
//         "timezone": -10800,
//         "sunrise": 1747386846,
//         "sunset": 1747427080
//     }
// }
