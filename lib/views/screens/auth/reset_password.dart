import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';
import '../../base/components/custom_text.dart';
import '../../base/components/custom_text_field.dart';
import '../../base/components/custom_toast.dart';
import '../../base/components/primary_button.dart';
import '../../base/widgets/app_custom_modal.dart';
import '../../base/widgets/app_custom_textfield.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _resetPassTEController = TextEditingController();
  final TextEditingController _confirmPassTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                children: [
                  const Center(child: CustomRichText(firstLabel: 'Reset', secondLabel: 'Password')),
                  const SizedBox(height: 14),

                  Center(
                    child: Text(
                      AppString.enterANewPassword,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.black.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(AppString.password, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 14),
                  AppCustomContainerField(
                    containerChild: MyTextFormFieldWithIcon(
                      isPassword: true,
                      formHintText: AppString.enterPassword,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                      controller: _resetPassTEController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return '${AppString.pleaseEnterYour} Password !!';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    AppString.confirmPassword,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 14),
                  AppCustomContainerField(
                    containerChild: MyTextFormFieldWithIcon(
                      isPassword: true,
                      formHintText: AppString.confirmPassword,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                      controller: _confirmPassTeController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return '${AppString.pleaseEnterYour} Password again !!';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                  PrimaryButton(
                    buttonText: AppString.confirm,
                    // Text that will appear on the button
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      clearingTextField();
                      if (_resetPassTEController.text.trim() !=
                          _confirmPassTeController.text.trim()) {
                        CustomToast().showToast(
                          context: context,
                          message: AppString.passwordsDoNotMatch,
                          isError: true,
                        );
                        return;
                      }
                      // TODO: password Reset logic
                      // if (_formKey.currentState!.validate()) {}
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ), // Curved top border
                        ),
                        builder: (BuildContext context) {
                          return const AppCustomModal();
                        },
                      ).whenComplete(() {
                        // This callback is called when the modal is dismissed
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearingTextField() {
    _resetPassTEController.clear();
    _confirmPassTeController.clear();
  }

  @override
  void dispose() {
    _confirmPassTeController.dispose();
    _resetPassTEController.dispose();
    super.dispose();
  }
}
