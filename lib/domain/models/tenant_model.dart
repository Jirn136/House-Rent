class TenantModel {

  String tenantName = "";
  int timestamp = 0;
  int advance = 0;

  TenantModel(
      {
      required String tN,
      required int ts,
      required int a}) {
    tenantName = tN;
    timestamp = ts;
    advance = a;
  }

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      tN: map['tenantName'],
      ts: map['timestamp'],
      a: map['advance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tenantName': tenantName,
      'advance': advance,
      'timestamp': timestamp
    };
  }

  @override
  String toString() {
    return 'TenantModel(tN: $tenantName, ts: $timestamp, a: $advance)';
  }
}
