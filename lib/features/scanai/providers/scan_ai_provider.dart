import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ScanAIProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _description = '';
  bool _isLoading = false;

  final List<SafetySetting> _safetySettings = [
    SafetySetting(
      HarmCategory.harassment,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.hateSpeech,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.sexuallyExplicit,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.dangerousContent,
      HarmBlockThreshold.none,
    ),
  ];

  XFile? get image => _image;

  String get description => _description;

  bool get isLoading => _isLoading;

  Future<void> getImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    _image = pickedImage;
    _description = '';
    notifyListeners();
  }

  Future<void> generateDescription() async {
    if (_image == null) {
      _description = 'Error: No image selected';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final apiKey = 'AIzaSyDoOwBz7dtFZ9Ffg46xyxtH5JQffIgFZeY';

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      safetySettings: _safetySettings,
    );

    final imageData = await _image!.readAsBytes();

    try {
      final response = await model.generateContent([
        Content.multi([
          TextPart('Describe this image:'),
          DataPart('image/jpeg', imageData),
        ])
      ]);

      _description = response.text!;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _description = 'Error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}
