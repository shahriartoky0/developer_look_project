import 'package:developper_look/views/screens/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_strings.dart';
import '../../base/components/custom_text.dart';
import '../../base/components/custom_text_field.dart';
import '../../base/components/primary_button.dart';
import '../../base/widgets/app_custom_textfield.dart';
import '../feed/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailTEController = TextEditingController();

  final TextEditingController _passwordTEController = TextEditingController();
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
                children: <Widget>[
                  Center(
                    child: const CustomRichText(
                      firstLabel: 'Sign In',
                      secondLabel: 'to your account',
                    ),
                  ),

                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      AppString.welcomeBackPleaseEnterYourDetails,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(
                        color: AppColors.black.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
                    AppString.email,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 14),
                  AppCustomContainerField(
                    containerChild: MyTextFormFieldWithIcon(
                      formHintText: AppString.enterEmail,
                      prefixIcon: const Icon(Icons.mail_outline),
                      controller: _emailTEController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return '${AppString.pleaseEnterYour} ${AppString.email}!!';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        // print("Email Input: $value");
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    AppString.password,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 14),
                  AppCustomContainerField(
                    containerChild: MyTextFormFieldWithIcon(
                      isPassword: true,
                      formHintText: AppString.enterPassword,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return '${AppString.pleaseEnterYour} Password !!';
                        }
                        return null;
                      },

                      onChanged: (String value) {
                        // print("Email Input: $value");
                      },
                    ),
                  ),

                  const SizedBox(height: 48),

                  PrimaryButton(
                    buttonText: AppString.signIn,
                    // Text that will appear on the button
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      clearingTextField();
                      Get.to(() => HomePage());
                    },
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(AppString.dontHaveAnAccount),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignUpPage());
                          },
                          child: Text(
                            AppString.signUp,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: AppColors.primaryColor),
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

  // validate Email Address
  String? isEmailValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void clearingTextField() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
