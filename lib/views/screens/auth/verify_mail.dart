import 'dart:async';
import 'dart:isolate';
import 'package:developper_look/views/screens/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';
import '../../base/components/custom_pin_code_field.dart';
import '../../base/components/custom_text.dart';
import '../../base/components/primary_button.dart';

class VerifyMailScreen extends StatefulWidget {
  const VerifyMailScreen({super.key});

  @override
  State<VerifyMailScreen> createState() => _VerifyMailScreenState();
}

class _VerifyMailScreenState extends State<VerifyMailScreen> {
  late ReceivePort _receivePort;
  late SendPort _sendPort;
  int _start = 60; // Timer starting value (seconds)
  bool _isButtonDisabled = true;
  late Isolate _isolate;
  late TextEditingController _forgotPasswordTEController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgotPasswordTEController = TextEditingController();
    _startTimer();
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolate.kill();
    super.dispose();
  }

  // Start the countdown timer using Isolate
  void _startTimer() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_startCountdown, _receivePort.sendPort);

    _receivePort.listen((count) {
      setState(() {
        _start = count;
        if (_start == 0) {
          _isButtonDisabled = false;
        }
      });
    });
  }

  // Function that runs in the isolate
  static void _startCountdown(SendPort sendPort) {
    int _start = 60;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _start--;
      sendPort.send(_start);
      if (_start == 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(32, 108, 32, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(child: CustomRichText(firstLabel: 'Verify', secondLabel: 'Email')),

                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      AppString.pleaseCheckYourEmailAndEnterTheCode,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.black.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const CustomPinCodeTextField(),
                  const SizedBox(height: 32),
                  // Timer Text
                  Center(
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.access_time_outlined),
                        Text(
                          _formatTime(_start),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  PrimaryButton(
                    buttonText: AppString.confirm,
                    // Text that will appear on the button
                    onPressed: () {
                      Get.to(() => const ResetPasswordPage());
                    },
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: !_isButtonDisabled,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppString.didNotReceiveCode,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            _resetTimer(); // Reset and start the timer again
                          },
                          child: Text(
                            AppString.resendIt,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Format the time in MM:SS
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // Reset the timer to initial state
  void _resetTimer() {
    setState(() {
      _start = 60;
      _isButtonDisabled = true;
    });
    _startTimer();
  }
}
