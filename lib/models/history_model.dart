class HistoryModel {
  final String? id, name, timeSpend, feesPaid;

  HistoryModel({this.timeSpend, this.feesPaid, this.id, this.name});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'] as String?,
      timeSpend: json['timeSpend'] as String?,
      feesPaid: json['feesPaid'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeSpend': timeSpend,
      'feesPaid': feesPaid,
    };
  }

  HistoryModel copyWith({
    String? id,
    String? timeSpend,
    String? feesPaid,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      timeSpend: timeSpend ?? this.timeSpend,
      feesPaid: feesPaid ?? this.feesPaid,
    );
  }
}
