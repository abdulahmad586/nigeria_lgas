import 'app_database.dart';

class NigeriaPlacesQuery {
  final AppDatabase _appDb = AppDatabase();

  /// Get all distinct States
  Future<List<String>> getStates() async {
    final result = await _appDb.rawQuery(
      'SELECT DISTINCT STATE FROM Pollingunits ORDER BY STATE ASC',
    );
    return result.map((row) => row['STATE'] as String).toList();
  }

  /// Get all distinct LGAs within a given State
  Future<List<String>> getLGAs(String state) async {
    final result = await _appDb.rawQuery(
      'SELECT DISTINCT LGA FROM Pollingunits WHERE STATE = ? ORDER BY LGA ASC',
      [state],
    );
    return result.map((row) => row['LGA'] as String).toList();
  }

  /// Get all distinct Wards within a given LGA (optionally filter by State)
  Future<List<String>> getWards(String lga, {String? state}) async {
    String sql = 'SELECT DISTINCT WARD FROM Pollingunits WHERE LGA = ?';
    List<Object?> args = [lga];

    if (state != null && state.isNotEmpty) {
      sql += ' AND STATE = ?';
      args.add(state);
    }

    sql += ' ORDER BY WARD ASC';

    final result = await _appDb.rawQuery(sql, args);
    return result.map((row) => row['WARD'] as String).toList();
  }
}
