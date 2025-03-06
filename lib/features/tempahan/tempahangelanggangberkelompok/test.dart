import 'dart:developer';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_service.dart';
import 'package:promis/features/tempahan/tempahangelanggangberkelompok/tempahangelanggangberkelompok_state.dart';
import 'package:riverpod/riverpod.dart';

final tempahanGelanggangBerkelompokNotifierProvider =
    NotifierProvider<TempahanGelanggangBerkelompokNotifier, TempahanGelanggangBerkelompokState>(
        TempahanGelanggangBerkelompokNotifier.new);

class TempahanGelanggangBerkelompokNotifier extends Notifier<TempahanGelanggangBerkelompokState> {
  @override
  TempahanGelanggangBerkelompokState build() {
    _fetchTempahanGelanggangBerkelompok();
    return  TempahanGelanggangBerkelompokStateInitial();
  }

  Future<void> _fetchTempahanGelanggangBerkelompok() async {
    state = TempahanGelanggangBerkelompokStateLoading();
    try {
      final apiService = ref.read(tempahanGelanggangBerkelompokApiServiceProvider);
      final response = await apiService.getTempahanGelanggangBerkelompok();

      log('Fetched data: ${response.data.length} items');
      state = TempahanGelanggangBerkelompokStateLoaded(
        tempahanGelanggangBerkelompok: response,
      );
    } catch (e, stackTrace) {
      log('Error fetching data: $e', stackTrace: stackTrace);
      state = TempahanGelanggangBerkelompokError();
    }
  }
}
