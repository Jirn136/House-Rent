class SelectedTenantModel {
  String tenantName = '';
  int tenantId = 0;
  int timestamp = 0;
  int reading = 0;
  int? water;
  int? unit = 0;
  int? balance;
  int? total = 0;

  SelectedTenantModel({
    required String tn,
    required int id,
    required int r,
    int? w,
    int? u,
    int? b,
    int? t,
    required int tms,
  }) {
    tenantName = tn;
    tenantId = id;
    reading = r;
    water = w;
    unit = u;
    balance = b;
    total = t;
    timestamp = tms;
  }

  factory SelectedTenantModel.fromMap(Map<String, dynamic> map) {
    return SelectedTenantModel(
      tn: map['tenantName'],
      id: map['tenantId'],
      r: map['reading'],
      u: map['unit'],
      t: map['total'],
      tms: map['timestamp'],
    );
  }

  @override
  String toString() {
    return 'SelectedTenantModel(id: $tenantId, timestamp: $timestamp, total: $total, unit: $unit, reading: $reading, water: $water)';
  }
}
