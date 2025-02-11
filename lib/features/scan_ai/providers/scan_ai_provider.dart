import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ScanAIProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _description = '';
  String _extractedText = '';
  String _handwritingText = '';
  String _documentAnalysis = '';
  String _nutritionInfo = '';
  String _mathSolution = '';
  String _productReview = '';
  String _propertyAnalysis = '';
  String _techSpecs = '';
  String _chartAnalysis = '';
  String _currencyInfo = '';
  String _translation = '';
  String _codeAnalysis = '';
  bool _isLoading = false;

  bool get hasResults =>
      _description.isNotEmpty ||
      _extractedText.isNotEmpty ||
      _handwritingText.isNotEmpty ||
      _documentAnalysis.isNotEmpty ||
      _nutritionInfo.isNotEmpty ||
      _mathSolution.isNotEmpty ||
      _productReview.isNotEmpty ||
      _propertyAnalysis.isNotEmpty ||
      _techSpecs.isNotEmpty ||
      _chartAnalysis.isNotEmpty ||
      _currencyInfo.isNotEmpty ||
      _translation.isNotEmpty ||
      _codeAnalysis.isNotEmpty;

  final List<SafetySetting> _safetySettings = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
  ];

  XFile? get image => _image;

  String get description => _description;

  String get extractedText => _extractedText;

  String get handwritingText => _handwritingText;

  String get documentAnalysis => _documentAnalysis;

  String get nutritionInfo => _nutritionInfo;

  String get mathSolution => _mathSolution;

  String get productReview => _productReview;

  String get propertyAnalysis => _propertyAnalysis;

  String get techSpecs => _techSpecs;

  String get chartAnalysis => _chartAnalysis;

  String get currencyInfo => _currencyInfo;

  String get translation => _translation;

  String get codeAnalysis => _codeAnalysis;

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

  // Add new methods
  Future<void> analyzeDocument() async {
    if (_image == null) return;
    await _processImage(
      'Analyze this document and provide a structured summary including key points, dates, and important information:',
      (response) => _documentAnalysis = response,
    );
  }

  Future<void> extractNutritionInfo() async {
    if (_image == null) return;
    await _processImage(
      'Extract nutrition information from this food label/package. Include calories, serving size, macronutrients, and key ingredients:',
      (response) => _nutritionInfo = response,
    );
  }

  Future<void> solveMathProblem() async {
    if (_image == null) return;
    await _processImage(
      'Solve this mathematical problem step by step and provide the final answer:',
      (response) => _mathSolution = response,
    );
  }

  Future<void> reviewProduct() async {
    if (_image == null) return;
    await _processImage(
      'Review this product and provide a detailed analysis including pros, cons, and recommendations:',
      (response) => _productReview = response,
    );
  }

  Future<void> analyzeProperty() async {
    if (_image == null) return;
    await _processImage(
      'Analyze this property and provide key details including location, size, features, and estimated value:',
      (response) => _propertyAnalysis = response,
    );
  }

  Future<void> extractTechSpecs() async {
    if (_image == null) return;
    await _processImage(
      'Extract technical specifications from this image. Include details such as dimensions, weight, and materials:',
      (response) => _techSpecs = response,
    );
  }

  Future<void> analyzeChart() async {
    if (_image == null) return;
    await _processImage(
      'Analyze this chart or graph and provide key insights and trends:',
      (response) => _chartAnalysis = response,
    );
  }

  Future<void> convertCurrency() async {
    if (_image == null) return;
    await _processImage(
      'Convert the currency in this image to USD. Include the amount and the original currency:',
      (response) => _currencyInfo = response,
    );
  }

  Future<void> translateText() async {
    if (_image == null) return;
    await _processImage(
      'Translate this text to English:',
      (response) => _translation = response,
    );
  }

  Future<void> analyzeCode() async {
    if (_image == null) return;
    await _processImage(
      'Analyze this code snippet and provide a detailed explanation of its functionality and purpose:',
      (response) => _codeAnalysis = response,
    );
  }

  Future<void> _processImage(
      String prompt, Function(String) updateState) async {
    _isLoading = true;
    notifyListeners();

    try {
      const apiKey = 'AIzaSyDt1PQOH_zUQrwsZokzhquQ4JNk-2pnJ00';
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
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
    _documentAnalysis = '';
    _nutritionInfo = '';
    _mathSolution = '';
    _productReview = '';
    _propertyAnalysis = '';
    _techSpecs = '';
    _chartAnalysis = '';
    _currencyInfo = '';
    _translation = '';
    _codeAnalysis = '';
    _image = null;
    notifyListeners();
  }
}
