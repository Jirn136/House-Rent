import 'package:house_rent/data/datasource/constants/constants.dart';
import 'package:house_rent/data/datasource/local/app_database.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';
import 'package:house_rent/domain/repository/reading_repository.dart';

class ReadingRepositoryImpl extends ReadingRepository {
  final AppDatabase _appDatabase;

  ReadingRepositoryImpl(this._appDatabase);

  @override
  Future<void> addReading(SelectedTenantModel cr) async {
    final db = await _appDatabase.db;
    await db.insert(
      Constants.readingDb,
      {
        'tenantName': cr.tenantName,
        'tenantId': cr.tenantId,
        'timestamp': cr.timestamp,
        'reading': cr.reading,
        'unit': cr.unit,
        'total': cr.total
      },
    );
  }

  @override
  Future<List<SelectedTenantModel>> getUserReading(int i, String tn) async {
    final db = await _appDatabase.db;
    try {
      final result = await db.rawQuery(
        'SELECT * FROM ${Constants.readingDb} '
        'WHERE ${Constants.readingDb}.tenantId = ? AND tenantName = ? '
        'ORDER BY ${Constants.readingDb}.timestamp DESC',
        [i, tn],
      );

      return result.map((map) => SelectedTenantModel.fromMap(map)).toList();
    } catch (e) {
      print("error:: $e");
      return [];
    }
  }

  @override
  Future<SelectedTenantModel?> getLastReading(int i, String tn) async {
    try {
      final result = await getUserReading(i, tn);
      print('result value:: $result \n i:: $i \n tn:: $tn');
      return result.first;
    } catch (e) {
      return null;
    }
  }
}
