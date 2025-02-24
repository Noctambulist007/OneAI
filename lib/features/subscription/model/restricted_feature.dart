import 'package:one_ai/features/subscription/model/subscription_plan.dart';

class RestrictedFeature {
  final String id;
  final String name;
  final String description;
  final SubscriptionType minimumPlan;
  final String lockedMessage;

  const RestrictedFeature({
    required this.id,
    required this.name,
    required this.description,
    required this.minimumPlan,
    required this.lockedMessage,
  });

  static const List<RestrictedFeature> textFeatures = [
    // Free Features
    RestrictedFeature(
      id: 'text_summarize',
      name: 'Text Summarization',
      description: 'Summarize long texts into key points',
      minimumPlan: SubscriptionType.free,
      lockedMessage: '',
    ),
    RestrictedFeature(
      id: 'text_grammar',
      name: 'Grammar Correction',
      description: 'Fix grammar and spelling errors',
      minimumPlan: SubscriptionType.free,
      lockedMessage: '',
    ),

    // Basic Plan Features
    RestrictedFeature(
      id: 'text_paraphrase',
      name: 'Paraphrase',
      description: 'Rewrite text in different ways',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for paraphrasing',
    ),
    RestrictedFeature(
      id: 'paragraph_generator',
      name: 'Paragraph Generator',
      description: 'Generate paragraphs from keywords',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for paragraph generation',
    ),
    RestrictedFeature(
      id: 'text_expand',
      name: 'Text Expansion',
      description: 'Expand short text into longer content',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for text expansion',
    ),
    RestrictedFeature(
      id: 'blog_intro',
      name: 'Blog Intros',
      description: 'Create engaging blog introductions',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for blog intros',
    ),
    RestrictedFeature(
      id: 'blog_conclusion',
      name: 'Blog Conclusions',
      description: 'Create impactful blog conclusions',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for blog conclusions',
    ),

    // Premium Plan Features
    RestrictedFeature(
      id: 'post_title',
      name: 'Post Title Generator',
      description: 'Generate engaging post titles',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for title generation',
    ),
    RestrictedFeature(
      id: 'blog_ideas',
      name: 'Blog Post Ideas',
      description: 'Generate unique blog post ideas',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for blog ideas',
    ),
    RestrictedFeature(
      id: 'blog_section',
      name: 'Blog Section',
      description: 'Create structured blog sections',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for blog sections',
    ),
    RestrictedFeature(
      id: 'article_generator',
      name: 'Article Generator',
      description: 'Generate complete articles',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for article generation',
    ),
    RestrictedFeature(
      id: 'text_sentiment',
      name: 'Sentiment Analysis',
      description: 'Analyze text sentiment and emotion',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for sentiment analysis',
    ),
    RestrictedFeature(
      id: 'text_keywords',
      name: 'Keywords Extraction',
      description: 'Extract key terms and phrases',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for keyword extraction',
    ),
  ];

  static const List<RestrictedFeature> imageFeatures = [
    // Free features
    RestrictedFeature(
      id: 'describe',
      name: 'Image Description',
      description: 'Get detailed description of images',
      minimumPlan: SubscriptionType.free,
      lockedMessage: '',
    ),
    RestrictedFeature(
      id: 'extract_text',
      name: 'Extract Text',
      description: 'Extract text from images',
      minimumPlan: SubscriptionType.free,
      lockedMessage: '',
    ),

    // Basic plan features
    RestrictedFeature(
      id: 'handwriting',
      name: 'Handwriting Recognition',
      description: 'Extract handwritten text',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for handwriting recognition',
    ),
    RestrictedFeature(
      id: 'document',
      name: 'Document Analysis',
      description: 'Analyze documents and forms',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for document analysis',
    ),
    RestrictedFeature(
      id: 'prescription',
      name: 'Prescription Reader',
      description: 'Read and analyze prescriptions',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for prescription reading',
    ),
    RestrictedFeature(
      id: 'nutrition',
      name: 'Nutrition Info',
      description: 'Extract nutrition information',
      minimumPlan: SubscriptionType.basic,
      lockedMessage: 'Upgrade to Basic plan for nutrition analysis',
    ),

    // Premium plan features
    RestrictedFeature(
      id: 'product',
      name: 'Product Analysis',
      description: 'Analyze product details and features',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for product analysis',
    ),
    RestrictedFeature(
      id: 'tech',
      name: 'Tech Specs',
      description: 'Extract technical specifications',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for technical analysis',
    ),
    RestrictedFeature(
      id: 'math',
      name: 'Math Solution',
      description: 'Solve mathematical problems',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for math solutions',
    ),
    RestrictedFeature(
      id: 'chart',
      name: 'Chart Analysis',
      description: 'Analyze charts and graphs',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for chart analysis',
    ),
    RestrictedFeature(
      id: 'code',
      name: 'Code Analysis',
      description: 'Analyze code snippets',
      minimumPlan: SubscriptionType.premium,
      lockedMessage: 'Upgrade to Premium for code analysis',
    ),
  ];
}
