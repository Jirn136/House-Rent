import 'package:house_rent/data/datasource/local/preferences.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';
import 'package:house_rent/domain/repository/reading_repository.dart';
import 'package:house_rent/utils/constants.dart';

import '../../di/app_module.dart';

class ReadingUseCase {
  final ReadingRepository r;

  ReadingUseCase(this.r);

  Future<void> executeAddReading(SelectedTenantModel stm) async {
    try {
      print('ruc :: $stm');
      final p = sl<SharedPrefs>();
      var l = await r.getLastReading(stm.tenantId, stm.tenantName);
      final w = p.getString(Constants.keyWater);
      final a = p.getString(Constants.keyAmount);
      final u = p.getString(Constants.keyUnit);
      final b = stm.balance ?? 0;
      var d = 0;
      if (l != null) {
        d = (stm.reading - l.reading);
      }

      if (l?.timestamp != stm.timestamp) {
        var t = d * (u.isNotEmpty ? int.parse(u) : 0) +
            b +
            (w.isNotEmpty ? int.parse(w) : 0) +
            (a.isNotEmpty ? int.parse(a) : 0);
        print(
            "c::w:$w, a:$a, u:$u d:$d $t curr: ${stm.reading} l: ${l?.reading}");

        await r.addReading(
          SelectedTenantModel(
            tn: stm.tenantName,
            id: stm.tenantId,
            r: stm.reading,
            u: d,
            t: t,
            tms: stm.timestamp,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<SelectedTenantModel>> getReading(int id, String tn) async {
    return r.getUserReading(id, tn);
  }
}
