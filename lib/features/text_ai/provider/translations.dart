class Translations {
  static final Map<String, Map<String, String>> _translations = {
    'write': {'en': 'Write', 'bn': 'লিখুন'},
    'result': {'en': 'Result', 'bn': 'ফলাফল'},
    'writing_ai': {'en': 'Writing AI', 'bn': 'লিখন AI'},
    'copy_success': {'en': 'Copied', 'bn': 'কপি করা হয়েছে'},
    'enter_text': {
      'en': 'Enter your text here...',
      'bn': 'এখানে আপনার টেক্সট লিখুন...'
    },
    'result_here': {
      'en': 'Result will appear here...',
      'bn': 'ফলাফল এখানে দেখা যাবে...'
    },
    'enter_text_error': {'en': 'Please enter text', 'bn': 'টেক্সট লিখুন'},
    'processing_error': {
      'en': 'Processing error occurred',
      'bn': 'প্রক্রিয়াকরণে সমস্যা হয়েছে'
    },
    'no_result': {'en': 'No result found', 'bn': 'কোন উত্তর পাওয়া যায়নি'},

    // Feature translations
    'paraphrase': {'en': 'Paraphrase', 'bn': 'পুনর্লিখন'},
    'spell_check': {'en': 'Spelling', 'bn': 'বানান'},
    'translate_en': {'en': 'English', 'bn': 'ইংরেজি'},
    'grammar': {'en': 'Grammar', 'bn': 'ব্যাকরণ'},
    'edit': {'en': 'Edit', 'bn': 'সম্পাদনা'},
    'summarize': {'en': 'Summary', 'bn': 'সারাংশ'},
    'story': {'en': 'Story', 'bn': 'গল্প'},
    'poem': {'en': 'Poem', 'bn': 'কবিতা'},
    'creative_writing': {'en': 'Creative', 'bn': 'সৃজনশীল'},
    'headline': {'en': 'Headline', 'bn': 'শিরোনাম'},
    'letter_write': {'en': 'Letter', 'bn': 'চিঠি'},
    'script_dialog': {'en': 'Dialog', 'bn': 'সংলাপ'},
    'academic': {'en': 'Academic', 'bn': 'একাডেমিক'},
    'business_proposal': {'en': 'Proposal', 'bn': 'প্রস্তাব'},
    'resume_cv': {'en': 'Resume', 'bn': 'রেজুমি'},
    'email_write': {'en': 'Email', 'bn': 'ইমেইল'},
    'report_generate': {'en': 'Report', 'bn': 'রিপোর্ট'},
    'presentation': {'en': 'Presentation', 'bn': 'প্রেজেন্টেশন'},
    // Section titles
    'section_basic': {'en': 'Basic Tools', 'bn': 'মৌলিক টুলস'},
    'section_creative': {'en': 'Creative Writing', 'bn': 'সৃজনশীল লেখা'},
    'section_professional': {'en': 'Professional', 'bn': 'পেশাদার'},
    'section_academic': {'en': 'Academic', 'bn': 'একাডেমিক'},
    'section_business': {'en': 'Business', 'bn': 'ব্যবসায়িক'},
  };

  static String get(String key, String language) {
    return _translations[key]?[language] ?? key;
  }
}
