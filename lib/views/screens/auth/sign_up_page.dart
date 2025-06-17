import 'package:developper_look/views/screens/auth/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';
import '../../base/components/custom_text.dart';
import '../../base/components/custom_text_field.dart';
import '../../base/components/reusable_date_picker_field.dart';
import '../../base/widgets/app_custom_textfield.dart';
import '../../base/widgets/custom_appbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _dateTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(headingText: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(32, 8, 32, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: CustomRichText(
                          firstLabel: 'Sign up with ',
                          secondLabel: 'Email',
                          secondLabelColor: AppColors.primaryColor,
                          firstLabelColor: AppColors.black,
                        ),
                      ),

                      const SizedBox(height: 14),
                      Center(
                        child: Text(
                          'Please enter your details.',
                          style: Theme.of(
                            context,
                          ).textTheme.displayMedium?.copyWith(color: AppColors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(AppString.name, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 14),
                      AppCustomContainerField(
                        containerChild: MyTextFormFieldWithIcon(
                          formHintText: AppString.firstName,

                          controller: _firstNameTEController,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return '${AppString.pleaseEnterYour} ${AppString.firstName} !!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppCustomContainerField(
                        containerChild: MyTextFormFieldWithIcon(
                          formHintText: AppString.lastName,

                          controller: _lastNameTEController,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return '${AppString.pleaseEnterYour} ${AppString.lastName} !!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// =================== Date of birth =======>
                      Text(
                        AppString.dateOfBirth,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 14),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.primaryColor, width: 1.8),
                        ),
                        child: ReusableDatePickerField(
                          color: const Color(0xFFEFF8FF),
                          hintText: AppString.date,
                          controller: _dateTEController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a date!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(AppString.yourEmail, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 14),

                      MyTextFormFieldWithIcon(
                        formHintText: AppString.enterYourEmail,
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.primaryColor),
                        controller: _emailTEController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return '${AppString.pleaseEnterYour} ${AppString.yourEmail}!!';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      Text(
                        AppString.phoneNumber,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 14),
                      AppCustomContainerField(
                        containerChild: MyTextFormFieldWithIcon(
                          formHintText: AppString.phoneNumber,
                          keyBoardType: TextInputType.number,

                          controller: _phoneTEController,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return '${AppString.pleaseEnterYour}${AppString.phoneNumber} !!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(AppString.password, style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 14),
                      AppCustomContainerField(
                        containerChild: MyTextFormFieldWithIcon(
                          isPassword: true,
                          formHintText: AppString.enterPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: AppColors.primaryColor,
                          ),
                          controller: _passwordTEController,
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
                      const SizedBox(height: 16),
                      AppCustomContainerField(
                        containerChild: MyTextFormFieldWithIcon(
                          isPassword: true,
                          formHintText: AppString.confirmPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: AppColors.primaryColor,
                          ),
                          controller: _confirmPasswordTEController,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return '${AppString.pleaseEnterYour} Password again !!';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue ?? false;
                              });
                            },
                            checkColor: AppColors.white,
                            focusColor: AppColors.white,
                            activeColor: AppColors.primaryColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                              },
                              child: Text(
                                AppString.byCreatingAnAccountIAcceptTheTermsConditions,
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppColors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _isChecked
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withValues(alpha: .5),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (_isChecked) {
                              setState(() {
                                clearTextFields(); // Clear fields inside setState to trigger UI refresh
                              });

                              // TODO: Sign up logic
                              // if (_formKey.currentState!.validate()) {}
                            }
                          },
                          child: Text(
                            AppString.signUp,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(AppString.alreadyHaveAnAccount),
                            TextButton(
                              onPressed: () {
                                Get.to(const SignInPage());
                              },
                              child: Text(
                                AppString.signIn,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearTextFields() {
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _dateTEController.clear();
    _emailTEController.clear();

    _phoneTEController.clear();

    _passwordTEController.clear();

    _confirmPasswordTEController.clear();
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _dateTEController.dispose();
    _emailTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
