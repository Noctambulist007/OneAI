import 'package:flutter/material.dart';
import 'package:one_ai/features/generate/providers/qr_feature_provider.dart';

class QRFeatureInput extends StatelessWidget {
  final String featureType;
  final QRFeatureProvider qrProvider;

  const QRFeatureInput({
    Key? key,
    required this.featureType,
    required this.qrProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (featureType.toLowerCase()) {
      case 'wifi':
        return _buildWifiInput();
      case 'website':
        return _buildUrlInput();
      case 'facebook':
      case 'youtube':
      case 'twitter':
      case 'instagram':
      case 'linkedin':
      case 'spotify':
      case 'whatsapp':
      case 'telegram':
      case 'discord':
      case 'slack':
        return _buildSocialMediaInput();
      case 'contacts':
        return _buildContactInput();
      case 'e-mail':
        return _buildEmailInput();
      case 'sms':
        return _buildSMSInput();
      case 'my card':
        return _buildMyCardInput();
      default:
        return TextField(
          controller: qrProvider.textController,
          decoration: InputDecoration(
            hintText: 'Enter ${featureType.toLowerCase()} content',
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => qrProvider.data = value,
        );
    }
  }

  Widget _buildWifiInput() {
    final ssidController = TextEditingController();
    final passwordController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: ssidController,
          decoration: const InputDecoration(
            labelText: 'Network Name (SSID)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            qrProvider.generateWifiQR(
              ssid: ssidController.text,
              password: passwordController.text,
            );
          },
          child: const Text('Generate WiFi QR'),
        ),
      ],
    );
  }

  Widget _buildUrlInput() {
    return Column(
      children: [
        TextField(
          controller: qrProvider.textController,
          decoration: const InputDecoration(
            labelText: 'Website URL',
            hintText: 'https://example.com',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => qrProvider.generateWebsiteQR(value),
        ),
      ],
    );
  }

  Widget _buildSocialMediaInput() {
    return Column(
      children: [
        TextField(
          controller: qrProvider.textController,
          decoration: InputDecoration(
            labelText: '$featureType Username/ID',
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => qrProvider.generateSocialProfileQR(
            platform: featureType,
            username: value,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInput() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final organizationController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email (Optional)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: organizationController,
          decoration: const InputDecoration(
            labelText: 'Organization (Optional)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            qrProvider.generateContactQR(
              name: nameController.text,
              phone: phoneController.text,
              email:
                  emailController.text.isNotEmpty ? emailController.text : null,
              organization: organizationController.text.isNotEmpty
                  ? organizationController.text
                  : null,
            );
          },
          child: const Text('Generate Contact QR'),
        ),
      ],
    );
  }

  Widget _buildEmailInput() {
    final emailController = TextEditingController();
    final subjectController = TextEditingController();
    final bodyController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: subjectController,
          decoration: const InputDecoration(
            labelText: 'Subject (Optional)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: bodyController,
          decoration: const InputDecoration(
            labelText: 'Message (Optional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            qrProvider.generateEmailQR(
              email: emailController.text,
              subject: subjectController.text.isNotEmpty
                  ? subjectController.text
                  : null,
              body: bodyController.text.isNotEmpty ? bodyController.text : null,
            );
          },
          child: const Text('Generate Email QR'),
        ),
      ],
    );
  }

  Widget _buildSMSInput() {
    final phoneController = TextEditingController();
    final messageController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Message (Optional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            qrProvider.generateSMSQR(
              phoneNumber: phoneController.text,
              message: messageController.text.isNotEmpty
                  ? messageController.text
                  : null,
            );
          },
          child: const Text('Generate SMS QR'),
        ),
      ],
    );
  }

  Widget _buildMyCardInput() {
    final nameController = TextEditingController();
    final titleController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final websiteController = TextEditingController();
    final companyController = TextEditingController();
    final addressController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Job Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: websiteController,
            decoration: const InputDecoration(
              labelText: 'Website (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: companyController,
            decoration: const InputDecoration(
              labelText: 'Company (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Address (Optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              qrProvider.generateMyCardQR(
                name: nameController.text,
                title: titleController.text,
                phone: phoneController.text,
                email: emailController.text,
                website: websiteController.text.isNotEmpty
                    ? websiteController.text
                    : null,
                company: companyController.text.isNotEmpty
                    ? companyController.text
                    : null,
                address: addressController.text.isNotEmpty
                    ? addressController.text
                    : null,
              );
            },
            child: const Text('Generate Business Card QR'),
          ),
        ],
      ),
    );
  }
}
