
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themasterchef/core/locale/app_locale.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widgets/cusotm_lodaing_indicator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header that contains image and welcome back text
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Center(
                        child: Text(
                          AppStrings.welcomeBack.tr(context),
                          style:
                          TextStyle(
                            color:Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          // style: Theme.of(context).textTheme.displayLarge,
                        )),
                    SizedBox(height: 30,),

                    CustomImage(
                      imgPath: AppAssets.appLogo,
                      h: 220.h,
                      w: 200.w,
                    ),
                    // Center(
                    //     child: Text(
                    //       AppStrings.welcomeBack.tr(context),
                    //       style:
                    //       TextStyle(
                    //         color:Colors.black,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       // style: Theme.of(context).textTheme.displayLarge,
                    //     )),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(24),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSucessState) {
                      showToast(
                          message: AppStrings.loginSucessfully.tr(context),
                          state: ToastStates.success);
                          navigateRepacement(context: context, route: Routes.home);
                    }
                    if (state is LoginErrorState) {
                      showToast(
                          message: state.message, state: ToastStates.error);
                    }
                  },
                  builder: (context, state) {

                    return Form(
                      key: BlocProvider.of<LoginCubit>(context).loginKey,
                      child: Column(
                        children: [
                          //! email
                          CustomTextFormField(
                            controller: BlocProvider.of<LoginCubit>(context)
                                .emailController,
                            hint: AppStrings.email.tr(context),
                            validate: (data) {
                              if (data!.isEmpty ||
                                  !data.contains('@gmail.com')) {
                                return AppStrings.pleaseEnterValidEmail
                                    .tr(context);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32.h),
                          //!password
                          CustomTextFormField(
                            controller: BlocProvider.of<LoginCubit>(context)
                                .passwordController,
                            hint: AppStrings.password.tr(context),
                            isPassword: BlocProvider.of<LoginCubit>(context)
                                .isLoginPasswordShowing,
                            icon:
                                BlocProvider.of<LoginCubit>(context).suffixIcon,
                            suffixIconOnPressed: () {
                              BlocProvider.of<LoginCubit>(context)
                                  .changeLoginPasswordSuffixIcon();
                            },
                            validate: (data) {
                              if (data!.length < 6 || data.isEmpty) {
                                return AppStrings.pleaseEnterValidPassword
                                    .tr(context);
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  navigateRepacement(
                                      context: context, route: Routes.sendCode);
                                },
                                child: Text(
                                  AppStrings.forgetPassword.tr(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          // state is LoginLoadingState
                              // ? const CusotmLoadingIndicator()
                              // :
                    CustomButton(
                            
                                  onPressed: () {
                                    if (BlocProvider.of<LoginCubit>(context)
                                        .loginKey
                                        .currentState!
                                        .validate()) {
                                      BlocProvider.of<LoginCubit>(context)
                                          .login();
                                    }
                                  },
                                  text: AppStrings.signIn.tr(context),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
