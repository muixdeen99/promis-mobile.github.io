import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promis/features/tempahan/tempahandewan/tempahandewan.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';

/// Provider to manage the TempahanDewan API Service instance.
/// Uses autoDispose to clean up resources when not needed.
final tempahanDewanApiServiceProvider = Provider.autoDispose((ref) {
  ref.keepAlive(); // Ensures the provider stays alive if needed elsewhere.
  return TempahanDewanApiService(
    ref: ref,
    apiService: DioApiService(
      createDio(EnvironmentConfig
          .dewanApiUrl), // Passes the Dio configuration for HTTP requests.
      EnvironmentConfig.dewanApiUrl,
    ), // Passes the Dio configuration for HTTP requests.
  );
});

/// Service class to handle TempahanDewan-related API calls.
class TempahanDewanApiService {
  final Ref ref; // Reference to the Riverpod provider.
  final ApiService
      apiService; // Instance of the API service for network requests.

  /// Constructor to initialize the service with required dependencies.
  TempahanDewanApiService({
    required this.ref,
    required this.apiService,
  });

  /// Holds the data fetched from the API.
  TempahanDewan? tempahanDewan;

  /// Fetches TempahanDewan data from the API.
  /// This method uses the Dio-based API service to send a GET request
  /// and parses the response into a `TempahanDewan` object.
  Future<TempahanDewan> getTempahanDewan() async {
    try {
      log('Fetching Tempahan Dewan data...');

      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/permohonan/pemohon/000102011860/dewan',
      );

      log('Raw Response: ${response.data}');

      // Parses the JSON response into a TempahanDewan object.
      final parsedResponse = TempahanDewan.fromJson(response.data);

      log('Parsed TempahanDewan: $parsedResponse');

      if (response.statusCode == 200) {
        tempahanDewan = parsedResponse;
        return parsedResponse;
      } else {
        tempahanDewan = parsedResponse;
        return parsedResponse;
      }
    } catch (e, s) {
      log('Error fetching Tempahan Dewan: $e\n$s');
      throw Exception('Failed to fetch Tempahan Dewan data');
    }
  }
}
