import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ScanAIProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _description = '';
  String _extractedText = '';
  String _handwritingText = '';
  bool _isLoading = false;

  bool get hasResults => _description.isNotEmpty || _extractedText.isNotEmpty || _handwritingText.isNotEmpty;

  final List<SafetySetting> _safetySettings = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
  ];

  // Getters
  XFile? get image => _image;
  String get description => _description;
  String get extractedText => _extractedText;
  String get handwritingText => _handwritingText;
  bool get isLoading => _isLoading;

  Future<void> getImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _image = pickedImage;
      _description = '';
      _extractedText = '';
      _handwritingText = '';
      notifyListeners();
    }
  }

  Future<void> generateDescription() async {
    if (_image == null) return;
    await _processImage(
      'Describe this image in detail but concisely:',
          (response) => _description = response,
    );
  }

  Future<void> extractText() async {
    if (_image == null) return;
    await _processImage(
      'Extract and list all text visible in this image. Only output the text, no descriptions or explanations:',
          (response) => _extractedText = response,
    );
  }

  Future<void> extractHandwriting() async {
    if (_image == null) return;
    await _processImage(
      'Extract and transcribe any handwritten text in this image. Focus on accuracy and maintaining the original structure. Only output the transcribed text:',
          (response) => _handwritingText = response,
    );
  }

  Future<void> _processImage(String prompt, Function(String) updateState) async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiKey = 'AIzaSyDt1PQOH_zUQrwsZokzhquQ4JNk-2pnJ00';
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        safetySettings: _safetySettings,
      );

      final imageData = await _image!.readAsBytes();
      final response = await model.generateContent([
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageData),
        ])
      ]);

      updateState(response.text ?? 'No content generated');
    } catch (e) {
      updateState('Error: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResults() {
    _description = '';
    _extractedText = '';
    _handwritingText = '';
    _image = null;
    notifyListeners();
  }
}