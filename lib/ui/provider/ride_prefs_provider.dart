import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/ui/provider/async_value.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> _pastPreferences;
  final RidePreferencesRepository repository;

  Future<void> _fetchPastPreferences() async {
    // 1- Handle loading
        _pastPreferences = AsyncValue.loading();
        notifyListeners();
        try {
        // 2 Fetch data
        List<RidePreference> pastPrefs = await repository.getPastPreferences();
        // 3 Handle success
        _pastPreferences = AsyncValue.success(pastPrefs);
        // 4 Handle error
        } catch (error) {
        _pastPreferences = AsyncValue.error(error);
        }
        notifyListeners();
  }

  RidesPreferencesProvider({required this.repository}) {
// For now past preferences are fetched only 1 time
// Your code
    _fetchPastPreferences();
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
  void _addPreference(RidePreference preference) async{
// Your code
    // check if the preference is not already in the history
    if (_pastPreferences.data != null &&
        _pastPreferences.data!.contains(preference)) {
      return;
    }
    await repository.addPreference(preference);
    _fetchPastPreferences();
  }


  List<RidePreference> get pastPreferences {
    if (_pastPreferences.data != null) {
      return _pastPreferences.data!.reversed.toList();
    } else {
      return [];
    }
  }

// History is returned from newest to oldest preference
  AsyncValue<List<RidePreference>> get preferencesHistory =>
      _pastPreferences;
}