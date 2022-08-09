import '../models/cities_model.dart';
import '../models/current_day_model.dart';
import '../models/weekly_forecast_model.dart';

abstract class NetworkRepository {
  Future<List<CitiesModel>?> loadingCitiesName();
  Future<CurrentDayModel?> loadingCurrentDayWeatherForecast(String cityName, String cityLink);
  Future<List<WeeklyForecastModel>?> loadingWeeklyWeatherForecast(String cityLink);
}
