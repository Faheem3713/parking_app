class Parking {
  final String? id, name;
  final DateTime? time;
  final bool? isBooked;
  final int? slotNo;

  Parking({this.id, this.name, this.time, this.isBooked, this.slotNo});

  factory Parking.fromJson(Map map) {
    final parsedTime = map['time'] as String;
    return Parking(
        id: map['id'] as String?,
        isBooked: map['isBooked'] as bool?,
        name: map['name'] as String?,
        time: parsedTime == '' ? null : DateTime.parse(parsedTime),
        slotNo: map['slotNo'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isBooked': isBooked,
      'name': name,
      'time': '${time ?? ''}',
      'slotNo': slotNo
    };
  }

  Parking copyWith(
      {String? id, String? name, DateTime? time, bool? isBooked, int? slotNo}) {
    return Parking(
        id: id ?? this.id,
        name: name ?? this.name,
        time: time ?? this.time,
        isBooked: isBooked ?? this.isBooked,
        slotNo: slotNo ?? this.slotNo);
  }
}
