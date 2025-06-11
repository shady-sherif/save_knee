import 'package:flutter/material.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/core/utils/paymob_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  AppointmentType? _selectedType; // Track the selected dropdown item
  String _buttonText = 'Select Appointment Type'; // Initial button text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown menu
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: kPrimaryColor, width: 1.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<AppointmentType>(
                value: _selectedType,
                hint: const Text('Choose Appointment Type'),
                isExpanded: true,
                underline: const SizedBox(),
                // Remove default underline
                icon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                items: AppointmentType.values.map((AppointmentType type) {
                  return DropdownMenuItem<AppointmentType>(
                    value: type,
                    child: Text(
                      type.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue;
                    _buttonText = newValue != null
                        ? 'Book ${newValue.name}'
                        : 'Select Appointment Type';
                  });
                },
              ),
            ),
            const SizedBox(height: 24.0),
            // Button with dynamic text
            Center(
              child: ElevatedButton(
                onPressed: _selectedType == null
                    ? null // Disable button if no selection
                    : () async {
                        // Add action for button (e.g., navigate or process)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Booking ${_selectedType?.name}')),
                        );
                        await _pay();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(_buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pay() async {
    PaymobManager()
        .getPaymentKey(_selectedType!.price, "EGP")
        .then((String paymentKey) {
      launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/929874?payment_token=$paymentKey"),
      );
    });
  }
}

enum AppointmentType {
  consultation(price: 50, name: 'Consultation'),
  followUp(price: 30, name: 'Follow-up'),
  therapySession(price: 75, name: 'Therapy Session'),
  checkUp(price: 40, name: 'Check-up');

  final int price;
  final String name;

  const AppointmentType({required this.price, required this.name});
}
