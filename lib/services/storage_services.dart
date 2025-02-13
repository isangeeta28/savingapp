import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/saving_model.dart';

class StorageService {
  Future<SavingsModel> loadSavings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('savings_data');
    if (data != null) {
      return SavingsModel.fromJson(jsonDecode(data));
    }
    return SavingsModel(compA: 0, compB: 0, history: []);
  }

  Future<void> saveSavings(SavingsModel savings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savings_data', jsonEncode(savings.toJson()));
  }
}
