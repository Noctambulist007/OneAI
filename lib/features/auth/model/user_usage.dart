import 'package:one_ai/features/subscription/model/subscription_plan.dart';

class UserUsage {
  int textGenerationCount;
  int imageGenerationCount;
  DateTime lastResetDate;
  DateTime lastUpdated;
  SubscriptionType subscriptionType;

  UserUsage({
    this.textGenerationCount = 0,
    this.imageGenerationCount = 0,
    DateTime? lastResetDate,
    DateTime? lastUpdated,
    this.subscriptionType = SubscriptionType.free,
  })  : lastResetDate = lastResetDate ?? DateTime.now(),
        lastUpdated = lastUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'textGenerationCount': textGenerationCount,
      'imageGenerationCount': imageGenerationCount,
      'lastResetDate': lastResetDate.toIso8601String(),
      'lastUpdated': DateTime.now().toIso8601String(),
      'subscriptionType': subscriptionType.toString(),
    };
  }

  factory UserUsage.fromMap(Map<String, dynamic> map) {
    return UserUsage(
      textGenerationCount: map['textGenerationCount']?.toInt() ?? 0,
      imageGenerationCount: map['imageGenerationCount']?.toInt() ?? 0,
      lastResetDate: map['lastResetDate'] != null
          ? DateTime.parse(map['lastResetDate'] as String)
          : DateTime.now(),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'] as String)
          : DateTime.now(),
      subscriptionType: map['subscriptionType'] != null
          ? SubscriptionType.values.firstWhere(
              (e) => e.toString() == map['subscriptionType'],
              orElse: () => SubscriptionType.free)
          : SubscriptionType.free,
    );
  }
}
