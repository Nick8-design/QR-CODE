import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/qr_payload.dart';
import '../domain/scan_result.dart';

final generatedHistoryProvider =
    StateNotifierProvider<GeneratedHistoryController, List<QrPayload>>(
      (ref) => GeneratedHistoryController(),
    );

final scannedHistoryProvider =
    StateNotifierProvider<ScannedHistoryController, List<ScanResult>>(
      (ref) => ScannedHistoryController(),
    );

class GeneratedHistoryController extends StateNotifier<List<QrPayload>> {
  GeneratedHistoryController() : super(const []) {
    _load();
  }

  static const _storageKey = 'generated_history_v1';

  void add(QrPayload payload) {
    state = [
      payload,
      ...state.where((item) => item.data != payload.data),
    ].toList();
    _save();
  }

  void delete(QrPayload payload) {
    state = state.where((item) => item.data != payload.data).toList();
    _save();
  }

  void clear() {
    state = const [];
    _save();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_storageKey);
    if (encoded == null) return;
    final decoded = jsonDecode(encoded);
    if (decoded is! List) return;
    state =
        decoded
            .whereType<Map>()
            .map((item) => QrPayload.fromJson(Map<String, Object?>.from(item)))
            .where((item) => item.data.isNotEmpty)
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(state.map((item) => item.toJson()).toList()),
    );
  }
}

class ScannedHistoryController extends StateNotifier<List<ScanResult>> {
  ScannedHistoryController() : super(const []) {
    _load();
  }

  static const _storageKey = 'scanned_history_v1';

  void add(ScanResult result) {
    state = [
      result,
      ...state.where((item) => item.rawValue != result.rawValue),
    ].toList();
    _save();
  }

  void delete(ScanResult result) {
    state = state.where((item) => item.rawValue != result.rawValue).toList();
    _save();
  }

  void clear() {
    state = const [];
    _save();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_storageKey);
    if (encoded == null) return;
    final decoded = jsonDecode(encoded);
    if (decoded is! List) return;
    state =
        decoded
            .whereType<Map>()
            .map((item) => ScanResult.fromJson(Map<String, Object?>.from(item)))
            .where((item) => item.rawValue.isNotEmpty)
            .toList()
          ..sort((a, b) => b.savedAt.compareTo(a.savedAt));
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(state.map((item) => item.toJson()).toList()),
    );
  }
}
