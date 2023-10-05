import 'package:books_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/localization/app_string.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/sized_box_high.dart';
import '../../../core/widgets/text_field.dart';
import '../../sign%20up/controller/sign_up_cubit.dart';
import '../../sign%20up/controller/sign_up_state.dart';

class SignUpScreeen extends StatelessWidget {
  const SignUpScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SignUpCubit(),
        child: Scaffold(
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSucceed) {
                Get.offAllNamed(RoutesName.homelayout);
              }
            },
            builder: (context, state) {
              return Form(
                key: SignUpCubit.get(context).formkey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.03,
                    vertical: MediaQuery.sizeOf(context).height * 0.10,
                  ),
                  child: ListView(
                    children: [
                      const AppLogo(),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.09,
                      ),
                      CustomeTextFormField(
                        controller: SignUpCubit.get(context).name,
                        hint: AppString.name,
                        textInputType: TextInputType.name,
                        onValidate: (value) {
                          if (value.toString().isEmpty) {
                            return "Enter your Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBoxHight(),
                      CustomeTextFormField(
                        controller: SignUpCubit.get(context).email,
                        hint: AppString.email,
                        textInputType: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value.toString().isEmpty) {
                            return "Enter your Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBoxHight(),
                      CustomeTextFormField(
                        controller: SignUpCubit.get(context).phone,
                        hint: AppString.email,
                        textInputType: TextInputType.phone,
                        onValidate: (value) {
                          if (value.toString().isEmpty) {
                            return "Enter your Phone";
                          }
                          return null;
                        },
                      ),
                      const SizedBoxHight(),
                      CustomeTextFormField(
                        controller: SignUpCubit.get(context).password,
                        hint: AppString.password,
                        textInputType: TextInputType.visiblePassword,
                        obscure: true,
                        onValidate: (value) {
                          if (value.toString().isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                      const SizedBoxHight(),
                      CustomeTextFormField(
                        controller: SignUpCubit.get(context).confrimePassword,
                        hint: AppString.confirmPassword,
                        textInputType: TextInputType.visiblePassword,
                        obscure: true,
                        onValidate: (value) {
                          if (value.toString().isEmpty) {
                            return "confirm password";
                          }
                          return null;
                        },
                      ),
                      const SizedBoxHight(),
                      CustomButton(
                        onTap: () {
                          if (SignUpCubit.get(context)
                              .formkey
                              .currentState!
                              .validate()) {
                            SignUpCubit.get(context).signUpMethod();
                          }
                        },
                        title: AppString.signUp,
                      ),
                      const SizedBoxHight(),
                      CustomButton(
                        backGroundColor: AppColor.darkBlue,
                        onTap: () {},
                        title: AppString.login,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
