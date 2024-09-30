import '../models/tenant_model.dart';

abstract class TenantRepository {
  Future<void> upsert(TenantModel tm);

  Future<List<TenantModel>> getAllTenants();

  Future<void> updateToNewTenant(TenantModel tm,TenantModel? pTm);
}
