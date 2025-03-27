import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
// For now past preferences are fetched only 1 time
// Your code
    _pastPreferences = repository.getPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
// Your code
    if(_currentPreference != pref) { // check if the preference is not equal to the current one
      _currentPreference = pref; // update the current preference
      _addPreference(pref); // add the preference to the history
      notifyListeners(); // notify the listeners
    }
  }
  void _addPreference(RidePreference preference) {
// Your code
    if(!_pastPreferences.contains(preference)){ // check if the preference is not already in the history
      _pastPreferences.add(preference);
      repository.addPreference(preference);
    }
  }
// History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();
}