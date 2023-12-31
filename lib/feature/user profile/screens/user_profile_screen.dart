import 'package:books_app/core/helper/show_toast_message.dart';
import 'package:books_app/core/localization/app_string.dart';
import 'package:books_app/core/widgets/cricle_progress_indicator.dart';
import 'package:books_app/feature/user%20profile/controller/profile_cubit.dart';
import 'package:books_app/feature/user%20profile/controller/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/sized_box_high.dart';
import '../../../core/widgets/text_field.dart';
import '../views/image_profile.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: ProfileCubit.getInstanse()..loadingInfo(),
        child: Scaffold(
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateSuccessfully) {
                ShowToast.sucuessMessage(
                  message: AppString.updateSucceed,
                );
              }
            },
            builder: (context, state) {
              if (state is LoadProfileInfo) {
                return const CircleLoading();
              }
              return ModalProgressHUD(
                inAsyncCall: ProfileCubit.getInstanse().loading,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.02,
                    vertical: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  child: Form(
                    key: ProfileCubit.getInstanse().formkey,
                    child: Column(
                      children: [
                        ImageProfile(
                          condition:
                              ProfileCubit.getInstanse().imageProfile == null,
                          imageFile: ProfileCubit.getInstanse().imageProfile,
                          onTap: () {
                            ProfileCubit.getInstanse().pickImage();
                          },
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              const SizedBoxHight(),
                              CustomeTextFormField(
                                controller:
                                    ProfileCubit.getInstanse().nameController,
                                hint: "Name",
                                textInputType: TextInputType.name,
                                readOnly: ProfileCubit.getInstanse().readOnly,
                              ),
                              const SizedBoxHight(),
                              CustomeTextFormField(
                                controller:
                                    ProfileCubit.getInstanse().emailController,
                                hint: "Email",
                                textInputType: TextInputType.emailAddress,
                                readOnly: true,
                              ),
                              const SizedBoxHight(),
                              CustomeTextFormField(
                                controller:
                                    ProfileCubit.getInstanse().phoneController,
                                hint: "Phone",
                                textInputType: TextInputType.phone,
                                readOnly: ProfileCubit.getInstanse().readOnly,
                              ),
                              const SizedBoxHight(),
                              CustomeTextFormField(
                                controller: ProfileCubit.getInstanse()
                                    .addressController,
                                hint: "Adress",
                                textInputType: TextInputType.text,
                                readOnly: ProfileCubit.getInstanse().readOnly,
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          onTap: () {
                            ProfileCubit.getInstanse().buttonOnPressed();
                          },
                          title: ProfileCubit.getInstanse().textButton,
                          backGroundColor: AppColor.darkBlue,
                          width: double.infinity,
                        )
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
