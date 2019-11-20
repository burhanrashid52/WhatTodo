import 'package:flutter_app/db/app_db.dart';

class LocationDB {
  //private internal constructor to make it singleton
  LocationDB._internal(this._appDatabase);

  AppDatabase _appDatabase;

  static final LocationDB _locationDb = LocationDB._internal(AppDatabase.get());

  static LocationDB get() {
    return _locationDb;
  }
}