import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RatePromptController {
  static const packageName = 'com.nickdieda.qrstudio';
  static const initialPromptDelay = Duration(minutes: 3);
  static const laterDelay = Duration(hours: 24);

  static const _hasRatedKey = 'rate_prompt_has_rated';
  static const _nextPromptAtKey = 'rate_prompt_next_prompt_at';

  Future<bool> shouldPromptNow() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(_hasRatedKey) ?? false) return false;

    final nextPromptAt = preferences.getInt(_nextPromptAtKey);
    if (nextPromptAt == null) return true;

    return DateTime.now().millisecondsSinceEpoch >= nextPromptAt;
  }

  Future<void> markRated() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_hasRatedKey, true);
    await preferences.remove(_nextPromptAtKey);
  }

  Future<void> remindLater() async {
    final preferences = await SharedPreferences.getInstance();
    final nextPromptAt = DateTime.now().add(laterDelay).millisecondsSinceEpoch;
    await preferences.setInt(_nextPromptAtKey, nextPromptAt);
  }

  Future<bool> openPlayStoreForRating() async {
    await markRated();

    final marketUri = Uri.parse('market://details?id=$packageName');
    if (await canLaunchUrl(marketUri)) {
      return launchUrl(marketUri, mode: LaunchMode.externalApplication);
    }

    final webUri = Uri.https('play.google.com', '/store/apps/details', {
      'id': packageName,
    });
    if (await canLaunchUrl(webUri)) {
      return launchUrl(webUri, mode: LaunchMode.externalApplication);
    }

    return false;
  }
}
