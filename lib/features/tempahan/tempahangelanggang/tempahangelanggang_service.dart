import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promis/features/tempahan/tempahangelanggang/tempahangelanggang.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/dio_api.dart';
import 'package:promis/shared/dio_config.dart';
import 'package:promis/shared/environment_config.dart';

/// Provider to manage the TempahanGelanggang API Service instance.
/// Uses autoDispose to clean up resources when not needed.
final tempahanGelanggangApiServiceProvider = Provider.autoDispose((ref) {
  ref.keepAlive(); // Ensures the provider stays alive if needed elsewhere.
  return TempahanGelanggangApiService(
    ref: ref,
    apiService: DioApiService(
      createDio(EnvironmentConfig
          .dewanApiUrl), // Passes the Dio configuration for HTTP requests.
      EnvironmentConfig.dewanApiUrl,
    ), // Passes the Dio configuration for HTTP requests.
  );
});

/// Service class to handle TempahanGelanggang-related API calls.
class TempahanGelanggangApiService {
  final Ref ref; // Reference to the Riverpod provider.
  final ApiService
      apiService; // Instance of the API service for network requests.

  /// Constructor to initialize the service with required dependencies.
  TempahanGelanggangApiService({
    required this.ref,
    required this.apiService,
  });

  /// Holds the data fetched from the API.
  TempahanGelanggang? tempahanGelanggang;

  /// Fetches TempahanGelanggang data from the API.
  /// This method uses the Dio-based API service to send a GET request
  /// and parses the response into a `TempahanGelanggang` object.
  Future<TempahanGelanggang> getTempahanGelanggang() async {
    try {
      log('Fetching Tempahan Gelanggang data...');

      var response = await apiService.makeRequest(
        RequestMethod.get,
        'mobile/permohonan/pemohon/000102011860/gelanggang',
      );

      log('Raw Response: ${response.data}');

      // Parses the JSON response into a TempahanGelanggang object.
      final parsedResponse = TempahanGelanggang.fromJson(response.data);

      log('Parsed TempahanGelanggang: $parsedResponse');

      if (response.statusCode == 200) {
        tempahanGelanggang = parsedResponse;
        return parsedResponse;
      } else {
        tempahanGelanggang = parsedResponse;
        return parsedResponse;
      }
    } catch (e, s) {
      log('Error fetching Tempahan Gelanggang: $e\n$s');
      throw Exception('Failed to fetch Tempahan Gelanggang data');
    }
  }
}
