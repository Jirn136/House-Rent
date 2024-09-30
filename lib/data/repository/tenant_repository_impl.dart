import 'package:house_rent/data/datasource/constants/constants.dart';
import 'package:house_rent/data/datasource/local/app_database.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/domain/repository/tenant_repository.dart';
import 'package:sqflite/sqflite.dart';

class TenantRepositoryImpl extends TenantRepository {
  final AppDatabase _appDatabase;

  TenantRepositoryImpl(this._appDatabase);

  @override
  Future<void> upsert(TenantModel tm) async {
    final db = await _appDatabase.db;

    await db.insert(
      Constants.tenantDb,
      tm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<TenantModel>> getAllTenants() async {
    final db = await _appDatabase.db;
    final result = await db.rawQuery('SELECT * FROM tenant');
    return result.map((map) => TenantModel.fromMap(map)).toList();
  }

  @override
  Future<void> updateToNewTenant(TenantModel tm, TenantModel? pTm) async {
    final db = await _appDatabase.db;
    try {
      upsert(tm);
      if (pTm != null) {
        db.delete(Constants.tenantDb,
            where: 'timestamp = ? AND tenantName = ? AND advance = ?',
            whereArgs: [pTm.timestamp, pTm.tenantName, pTm.advance]);

        db.update(Constants.readingDb,
            {'tenantId': tm.timestamp, 'tenantName': tm.tenantName},
            where: 'tenantId = ? AND tenantName = ?',
            whereArgs: [pTm.timestamp, pTm.tenantName]);
      }
    } catch (e) {
      print('Update Failed');
    }
  }
}
