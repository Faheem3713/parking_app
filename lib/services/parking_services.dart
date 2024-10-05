import 'package:firebase_database/firebase_database.dart';
import 'package:parking/core/helpers/logger.dart';
import 'package:parking/models/history_model.dart';
import 'package:parking/models/parking_model.dart';

class ParkingServices {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<void> manageSlots(int numberOfSlots) async {
    Map<String, dynamic> updates = {};
    await ref.child('slots').remove();
    for (var i = 0; i < numberOfSlots; i++) {
      updates['slots/$i'] = {
        'slotNo': i,
        'id': '',
        'isBooked': false,
        'name': '',
        'time': '',
      };
    }
    await ref.update(updates);
  }

  Future<void> bookSlot(Parking data) async {
    await ref.child('slots/${data.slotNo}').set(data.toJson());
  }

  Future<void> deleteSlot(Parking data) async {
    printLog('message');
    await ref.child('slots/${data.slotNo}').set(Parking(
          isBooked: false,
          name: '',
          time: null,
          slotNo: data.slotNo,
        ).toJson());
  }

  Future<void> saveHistory(HistoryModel data) async {
    final key = ref.child('history/${data.id}').push().key;
    await ref
        .child('history/${data.id}/$key')
        .set(data.copyWith(id: key).toJson());
  }

  Future<List<HistoryModel>> getHistoryById(String id) async {
    final snapshot = await ref.child('history/$id').get();
    Map<String, dynamic> data =
        Map<String, dynamic>.from(snapshot.value as Map);
    return data.values.map((entry) {
      return HistoryModel.fromJson(Map<String, dynamic>.from(entry));
    }).toList();
  }

  Stream<List<Parking>> getData() async* {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('slots');
    final Stream<DatabaseEvent> stream = ref.onValue;

    await for (final event in stream) {
      final parkData = (event.snapshot.value as List)
          .map((e) => Parking.fromJson(e as Map))
          .toList();

      yield parkData;
    }
  }
}
