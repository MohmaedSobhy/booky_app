import 'package:books_app/core/API/api_keys.dart';
import 'package:books_app/core/routes/route_name.dart';
import 'package:books_app/core/widgets/cricle_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
      child: BlocProvider.value(
        value: SignUpCubit.getInstanse(),
        child: Scaffold(
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSucceed) {
                Get.offAllNamed(RoutesName.homelayout);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: SignUpCubit.getInstanse().loading,
                progressIndicator: const CircleLoading(),
                child: Form(
                  key: SignUpCubit.getInstanse().formkey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.03,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.10),
                        const AppLogo(),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.09,
                        ),
                        CustomeTextFormField(
                          controller: SignUpCubit.getInstanse().name,
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
                          controller: SignUpCubit.getInstanse().email,
                          hint: AppString.email,
                          textInputType: TextInputType.emailAddress,
                          onValidate: (value) {
                            if (SignUpCubit.getInstanse()
                                .hasErrorMessage(key: APIKey.email)
                                .isNotEmpty) {
                              return "The email has already been taken";
                            }
                            if (value.toString().isEmpty) {
                              return "Enter your Email";
                            }
                            return null;
                          },
                        ),
                        const SizedBoxHight(),
                        CustomeTextFormField(
                          controller: SignUpCubit.getInstanse().phone,
                          hint: AppString.phone,
                          textInputType: TextInputType.phone,
                          onValidate: (value) {
                            if (SignUpCubit.getInstanse()
                                .hasErrorMessage(key: APIKey.phone)
                                .isNotEmpty) {
                              return "The phone has already been taken";
                            }
                            if (value.toString().isEmpty) {
                              return "Enter your Phone";
                            }
                            return null;
                          },
                        ),
                        const SizedBoxHight(),
                        CustomeTextFormField(
                          controller: SignUpCubit.getInstanse().password,
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
                          controller:
                              SignUpCubit.getInstanse().confrimePassword,
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
                            SignUpCubit.getInstanse().errorMessages.clear();
                            if (SignUpCubit.getInstanse()
                                .formkey
                                .currentState!
                                .validate()) {
                              SignUpCubit.getInstanse().signUpMethod();
                            }
                          },
                          title: AppString.signUp,
                        ),
                        const SizedBoxHight(),
                        CustomButton(
                          backGroundColor: AppColor.darkBlue,
                          onTap: () {
                            Get.offAllNamed(RoutesName.login);
                          },
                          title: AppString.login,
                        ),
                      ],
                    ),
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
