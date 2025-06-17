import 'package:developper_look/views/screens/auth/verify_mail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';
import '../../base/components/custom_text.dart';
import '../../base/components/custom_text_field.dart';
import '../../base/components/primary_button.dart';
import '../../base/widgets/app_custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _forgotPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: CustomRichText(firstLabel: 'Forgot', secondLabel: 'Password')),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  AppString.pleaseEnterYourEmailAddressToResetPassword,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.black.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              const SizedBox(height: 24),
              Text(AppString.email, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 14),
              AppCustomContainerField(
                containerChild: MyTextFormFieldWithIcon(
                  controller: _forgotPasswordTEController,
                  validator: (String? value) {
                    return isEmailValid(value);
                  },
                  formHintText: AppString.enterEmail,
                  prefixIcon: const Icon(Icons.mail_outline, color: AppColors.primaryColor),
                ),
              ),

              const SizedBox(height: 32),

              PrimaryButton(
                buttonText: AppString.sendOTP,
                // Text that will appear on the button
                onPressed: () {
                  /// TODO: OTP logic
                  // // if (_formKey.currentState!.validate()) {}
                  Get.to(() => const VerifyMailScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? isEmailValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void clearTextFields() {
    _forgotPasswordTEController.clear();
  }

  @override
  void dispose() {
    _forgotPasswordTEController.dispose();

    super.dispose();
  }
}
