enum SubscriptionType {
  free,
  basic,
  premium,
}

class SubscriptionPlan {
  final SubscriptionType type;
  final String id;
  final String name;
  final String description;
  final double price;
  final int textLimit;
  final int imageLimit;
  final bool isUnlimited;

  const SubscriptionPlan({
    required this.type,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.textLimit,
    required this.imageLimit,
    this.isUnlimited = false,
  });

  static const free = SubscriptionPlan(
    type: SubscriptionType.free,
    id: 'free_plan',
    name: 'Free Plan',
    description: 'Basic access with limited features',
    price: 0,
    textLimit: 10,
    imageLimit: 3,
  );

  static const basic = SubscriptionPlan(
    type: SubscriptionType.basic,
    id: 'oneai.sub.basic.monthly', // Real product ID from Play Console
    name: 'Basic Plan',
    description: 'Enhanced access with higher limits',
    price: 4.99,
    textLimit: 100,
    imageLimit: 5,
  );

  static const premium = SubscriptionPlan(
    type: SubscriptionType.premium,
    id: 'oneai.sub.premium.monthly', // Real product ID from Play Console
    name: 'Premium Plan',
    description: 'Unlimited text generation and enhanced image processing',
    price: 9.99,
    textLimit: -1,
    imageLimit: 20,
    isUnlimited: true,
  );
} 