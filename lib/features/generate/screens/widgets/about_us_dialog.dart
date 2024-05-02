import 'package:dashscan/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsDialog extends StatefulWidget {
  const AboutUsDialog({super.key});

  @override
  AboutUsDialogState createState() => AboutUsDialogState();
}

class AboutUsDialogState extends State<AboutUsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffe7ebee),
      title: const Center(
        child: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
            color: AppColors.black,
            fontSize: 18,
          ),
        ),
      ),
      content: SlideTransition(
        position: _offsetAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/logos/elort_logo_raw.png',
              height: 40,
            ),
            const SizedBox(height: 15),
            const Text('Powered by',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.black)),
            GestureDetector(
              onTap: () {
                launch('https://elort.com');
              },
              child: const Text('elort.com',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.primary)),
            ),
            const SizedBox(height: 10),
            const Text('Contact us',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.black)),
            GestureDetector(
              onTap: () {
                launch('mailto:helloelort@gmail.com');
              },
              child: const Text('helloelort@gmail.com',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.primary)),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(
                    color: AppColors.primary,
                  )),
                ),
                child: const Text('Close',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.black)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
