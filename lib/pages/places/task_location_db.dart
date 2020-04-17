import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/places/places_models.dart';
import 'package:flutter_app/pages/places/task_location.dart';

class LocationDB {
  //private internal constructor to make it singleton
  LocationDB._internal(this._appDatabase);

  AppDatabase _appDatabase;

  static final LocationDB _locationDb = LocationDB._internal(AppDatabase.get());

  static LocationDB get() {
    return _locationDb;
  }

  Future createLocation(LocationInfo locationInfo) async {
    final db = await _appDatabase.getDb();
    await db.execute(
        "INSERT INTO ${TaskLocation.tblTaskLocation} (${TaskLocation.dbLocationName},${TaskLocation.dbAddress},${TaskLocation.dbLat},${TaskLocation.dbLng})"
        " VALUES(${locationInfo.locationName},${locationInfo.address},${locationInfo.lat},${locationInfo.lng});");
    return 1;
  }
}
