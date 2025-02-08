class PromptHelper {
  static String getPrompt(String action, String text) {
    switch (action) {
      case 'paraphrase':
        return "পুনর্লিখন করুন এবং বাংলায় উত্তর দিন:\n$text";
      case 'grammar':
        return "বাক্যগঠন ও ব্যাকরণ পরীক্ষা করে বাংলায় উত্তর দিন:\n$text";
      case 'ai_detect':
        return "এই টেক্সটটি AI দ্বারা লেখা কিনা বিশ্লেষণ করে বাংলায় জানান:\n$text";
      case 'plagiarism':
        return "এই টেক্সটে অনুলিপি বা চুরির সম্ভাবনা আছে কিনা বিশ্লেষণ করে বাংলায় জানান:\n$text";
      case 'summarize':
        return "সংক্ষিপ্ত সারাংশ বাংলায় লিখুন:\n$text";
      case 'translate_en':
        return "ইংরেজিতে অনুবাদ করুন:\n$text";
      case 'translate_bn':
        return "বাংলায় অনুবাদ করুন:\n$text";
      case 'edit':
        return "সম্পাদনা করে উন্নত করুন এবং বাংলায় উত্তর দিন:\n$text";
      case 'story':
        return "এই বিষয়ে একটি গল্প বাংলায় লিখুন:\n$text";
      case 'poem':
        return "এই বিষয়ে একটি কবিতা বাংলায় লিখুন:\n$text";
      case 'headline':
        return "এই টেক্সট থেকে আকর্ষণীয় শিরোনাম বাংলায় তৈরি করুন:\n$text";
      case 'academic':
        return "একাডেমিক স্টাইলে পুনর্লিখন করে বাংলায় উত্তর দিন:\n$text";
      case 'poetic_prose':
        return "এই মূল টেক্সটকে কাব্যিক গদ্যে রূপান্তর করুন:\n$text";
      case 'dialect_convert':
        return "এই টেক্সটটি বাংলার বিভিন্ন উপভাষায় রূপান্তর করুন (যেমন: চট্টগ্রামি, সিলেটি, বরিশাইলি):\n$text";
      case 'sentiment_analyze':
        return "এই টেক্সটের আবেগিক টোন বিশ্লেষণ করুন এবং তার প্রভাব ব্যাখ্যা করুন:\n$text";
      case 'proverb_generate':
        return "এই টেক্সটের মূল বক্তব্য থেকে একটি প্রবাদ বাক্য তৈরি করুন:\n$text";
      case 'formal_informal':
        return "এই টেক্সটটি আনুষ্ঠানিক বা অনানুষ্ঠানিক ভাষায় রূপান্তর করুন:\n$text";
      case 'creative_writing':
        return "এই টেক্সটের বিষয়বস্তু ভিত্তিতে একটি সৃজনশীল লেখা তৈরি করুন:\n$text";
      case 'word_simplify':
        return "এই টেক্সটটি সরল এবং সহজবোধ্য ভাষায় লিখুন:\n$text";
      case 'metaphor_generate':
        return "এই টেক্সটের জন্য কিছু রেखাচিত্র বা রূপক তৈরি করুন:\n$text";
      case 'letter_write':
        return "এই বিষয়ে একটি আনুষ্ঠানিক/ব্যক্তিগত চিঠি লিখুন:\n$text";
      case 'script_dialog':
        return "এই বিষয়ের উপর একটি সংলাপ বা দৃশ্য পটভূমি লিখুন:\n$text";
      case 'idiom_explain':
        return "বাংলা প্রবাদ ও প্রচলিত বাক্যগুচ্ছ ব্যবহার করে এই টেক্সটটি ব্যাখ্যা করুন:\n$text";
      case 'news_article':
        return "এই বিষয়ে একটি সংবাদ পত্রের নিবন্ধ লিখুন:\n$text";
      case 'essay_write':
        return "এই বিষয়ে একটি সম্পূর্ণ প্রবন্ধ রচনা করুন:\n$text";
      case 'speech_write':
        return "এই বিষয়ে একটি আবেগঘন ভাষণ লিখুন:\n$text";
      case 'debate_point':
        return "এই বিষয়ে বিতর্কের পক্ষ ও বিপক্ষ যুক্তি তৈরি করুন:\n$text";
      case 'social_media_post':
        return "এই বিষয়ে সোশ্যাল মিডিয়ার জন্য আকর্ষণীয় পোস্ট তৈরি করুন:\n$text";
      case 'literary_analysis':
        return "এই টেক্সটের সাহিত্যিক বিশ্লেষণ করুন:\n$text";
      case 'word_origin':
        return "এই টেক্সটের মূল শব্দগুলির উৎপত্তি ও ঐতিহাসিক পটভূমি ব্যাখ্যা করুন:\n$text";
      case 'tone_adjust':
        return "এই টেক্সটের টোন পরিবর্তন করে আরও আকর্ষণীয় করুন:\n$text";
      case 'emotional_writing':
        return "এই বিষয়ে আবেগমক্ত এবং সংবেদনশীল লেখা তৈরি করুন:\n$text";
      // Content Creation Prompts
      case 'news_write':
        return "এই বিষয়ে একটি সংবাদ প্রতিবেদন তৈরি করুন:\n$text";
      case 'blog_post':
        return "এই বিষয়ে একটি আকর্ষণীয় ব্লগ পোস্ট লিখুন:\n$text";
      case 'research_paper':
        return "এই বিষয়ে একটি গবেষণা প্রবন্ধ তৈরি করুন (ভূমিকা, পদ্ধতি, ফলাফল, আলোচনা):\n$text";
      case 'business_proposal':
        return "এই ধারণার জন্য একটি পেশাদার ব্যবসায়িক প্রস্তাব তৈরি করুন (নির্বাহী সারসংক্ষেপ, বাজার বিশ্লেষণ, আর্থিক প্রক্ষেপণ):\n$text";
      case 'resume_cv':
        return "এই তথ্য ব্যবহার করে একটি আধুনিক ও পেশাদার রেজুমে তৈরি করুন:\n$text";

      // Educational Tools
      case 'math_solver':
        return "এই গাণিতিক সমস্যাটি ধাপে ধাপে সমাধান করুন, প্রতিটি পদক্ষেপ ব্যাখ্যা করুন:\n$text";
      case 'chemistry_help':
        return "এই রাসায়নিক প্রতিক্রিয়া/ধারণাটি সহজ ভাষায় ব্যাখ্যা করুন, উদাহরণসহ:\n$text";
      case 'physics_explain':
        return "এই পদার্থবিজ্ঞানের ধারণাটি দৈনন্দিন জীবনের উদাহরণ সহ সহজভাবে ব্যাখ্যা করুন:\n$text";
      case 'biology_concepts':
        return "এই জীববিজ্ঞানের ধারণাটি ছবি/চিত্র বর্ণনাসহ বিস্তারিত ব্যাখ্যা করুন:\n$text";
      case 'history_facts':
        return "এই ঐতিহাসিক ঘটনার বিস্তারিত বিবরণ দিন, কারণ ও প্রভাব সহ:\n$text";

      // Professional Tools
      case 'email_write':
        return "এই বিষয়ে একটি পেশাদার ইমেইল লিখুন (সূচনা, মূল বিষয়, উপসংহার):\n$text";
      case 'meeting_minutes':
        return "এই সভার জন্য একটি পূর্ণাঙ্গ বিবরণী তৈরি করুন (উপস্থিতি, আলোচ্য বিষয়, সিদ্ধান্ত):\n$text";
      case 'presentation':
        return "এই বিষয়ে একটি প্রভাবশালী প্রেজেন্টেশন স্ক্রিপ্ট তৈরি করুন:\n$text";
      case 'report_generate':
        return "এই তথ্য নিয়ে একটি বিস্তারিত প্রতিবেদন তৈরি করুন:\n$text";
      case 'legal_doc':
        return "এই বিষয়ে একটি আইনি দলিল খসড়া তৈরি করুন:\n$text";

      // Creative Writing
      case 'novel_writing':
        return "এই ধারণা নিয়ে একটি আকর্ষণীয় গল্পের প্লট তৈরি করুন:\n$text";
      case 'screenplay':
        return "এই গল্প/ঘটনা নিয়ে একটি চিত্রনাট্য লিখুন:\n$text";
      case 'song_lyrics':
        return "এই বিষয়/ভাব নিয়ে একটি গানের কথা লিখুন:\n$text";
      case 'comic_script':
        return "এই গল্পটিকে একটি কমিক স্ক্রিপ্টে রূপান্তর করুন:\n$text";
      case 'character_dev':
        return "এই চরিত্রটির বিস্তারিত বর্ণনা ও বিকাশ লিখুন:\n$text";

      // Technical Writing
      case 'code_document':
        return "এই কোডের জন্য বিস্তারিত ডকুমেন্টেশন লিখুন:\n$text";
      case 'api_docs':
        return "এই API এন্ডপয়েন্টের জন্য বিস্তারিত ডকুমেন্টেশন তৈরি করুন:\n$text";
      case 'tech_manual':
        return "এই প্রযুক্তি/সফটওয়্যারের জন্য ব্যবহারকারী নির্দেশিকা লিখুন:\n$text";
      case 'bug_report':
        return "এই সমস্যার জন্য একটি বিস্তারিত বাগ রিপোর্ট তৈরি করুন:\n$text";
      case 'system_spec':
        return "এই সিস্টেমের জন্য বিস্তারিত স্পেসিফিকেশন লিখুন:\n$text";

      // Marketing Content
      case 'ad_copy':
        return "এই পণ্য/সেবার জন্য আকর্ষণীয় বিজ্ঞাপন কপি লিখুন:\n$text";
      case 'product_desc':
        return "এই পণ্যের জন্য বিক্রয়-কেন্দ্রিক বিবরণ লিখুন:\n$text";
      case 'seo_content':
        return "এই বিষয়ে SEO-অপ্টিমাইজড কন্টেন্ট তৈরি করুন:\n$text";
      case 'social_caption':
        return "এই ছবি/পোস্টের জন্য আকর্ষণীয় সোশ্যাল মিডিয়া ক্যাপশন লিখুন:\n$text";
      case 'brand_story':
        return "এই ব্র্যান্ডের জন্য একটি আবেগীয় ব্র্যান্ড স্টোরি লিখুন:\n$text";

      // Analysis Tools
      case 'data_analysis':
        return "এই ডেটা সেট বিশ্লেষণ করে মূল ইনসাইট গুলো বের করুন:\n$text";
      case 'market_research':
        return "এই বাজার/শিল্পের জন্য একটি বিস্তৃত গবেষণা প্রতিবেদন তৈরি করুন:\n$text";
      case 'competitor_analysis':
        return "এই প্রতিযোগীদের তুলনামূলক বিশ্লেষণ করুন:\n$text";
      case 'trend_analysis':
        return "এই ক্ষেত্রে বর্তমান ট্রেন্ড এবং ভবিষ্যত প্রবণতা বিশ্লেষণ করুন:\n$text";
      case 'user_feedback':
        return "এই ব্যবহারকারী প্রতিক্রিয়া বিশ্লেষণ করে মূল সুপারিশগুলো বের করুন:\n$text";

      // Personal Development
      case 'goal_setting':
        return "এই লক্ষ্যের জন্য একটি SMART পরিকল্পনা তৈরি করুন:\n$text";
      case 'habit_tracker':
        return "এই অভ্যাসের জন্য একটি ট্র্যাকিং সিস্টেম তৈরি করুন:\n$text";
      case 'daily_journal':
        return "আজকের দিনের জন্য একটি গভীর প্রতিফলনমূলক জার্নাল এন্ট্রি লিখুন:\n$text";
      case 'meditation_guide':
        return "এই ধরনের ধ্যানের জন্য একটি গাইডেড মেডিটেশন স্ক্রিপ্ট লিখুন:\n$text";
      case 'workout_plan':
        return "এই লক্ষ্যের জন্য একটি পূর্ণাঙ্গ ব্যায়াম পরিকল্পনা তৈরি করুন:\n$text";

      // Financial Tools
      case 'budget_plan':
        return "এই আয়/ব্যয়ের জন্য একটি বিস্তারিত বাজেট পরিকল্পনা তৈরি করুন:\n$text";
      case 'expense_track':
        return "এই ব্যয়গুলোর জন্য একটি ট্র্যাকিং সিস্টেম তৈরি করুন:\n$text";
      case 'investment_advice':
        return "এই পরিস্থিতির জন্য বিনিয়োগ পরামর্শ প্রদান করুন:\n$text";
      case 'tax_calculate':
        return "এই আয়/ব্যয়ের উপর কর গণনা করুন এবং পরামর্শ দিন:\n$text";
      case 'financial_report':
        return "এই আর্থিক তথ্যের জন্য একটি বিস্তারিত প্রতিবেদন তৈরি করুন:\n$text";
      case 'resume_builder':
        return "এই তথ্য ব্যবহার করে একটি আধুনিক ও পেশাদার রেজুমে তৈরি করুন:\n$text";
      default:
        return "দয়া করে আপনার অনুরোধ বিস্তারিত ব্যাখ্যা করুন:\n$text";
    }
  }
}
