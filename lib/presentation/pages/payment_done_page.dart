import 'package:flutter/material.dart';
import 'package:lumo_book/presentation/pages/home_page.dart';
import 'package:lumo_book/presentation/widgets/button_text.dart';
import '../../core/config/design_config.dart';
import '../widgets/bottom_navigation.dart';

class PaymentDonePage extends StatefulWidget {
  const PaymentDonePage({super.key});

  @override
  State<PaymentDonePage> createState() => _PaymentDonePageState();
}

class _PaymentDonePageState extends State<PaymentDonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              width: 220,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: DesignConfig.border,
                image: const DecorationImage(
                  image: AssetImage('assets/image/payment.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Payment Is Done Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: DesignConfig.subTextColor,
                fontSize: DesignConfig.headerSize,
                fontWeight: DesignConfig.semiBold,
                fontFamily: DesignConfig.fontFamily,
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonText(
                backgroundColor: DesignConfig.primaryColor,
                title: 'Go Home',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
