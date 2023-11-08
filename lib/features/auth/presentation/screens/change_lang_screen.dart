import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themasterchef/core/locale/app_locale.dart';

import '../../../../core/bloc/cubit/global_cubit.dart';
import '../../../../core/bloc/cubit/global_state.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image.dart';

class ChangeLangScreen extends StatelessWidget {
  const ChangeLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.primary,

        body: Stack(
          fit: StackFit.expand,
          children: [
            // const CustomImage(
            // imgPath: AppAssets.appLogo,
            //   // w: double.infinity,
            //  ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(
                    height: 116.h,
                  ),
                   CustomImage(
                    imgPath: AppAssets.appLogo,
                     h: 200.h,
                    w: 180.w,
                   ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    AppStrings.welcomeToChefApp.tr(context),
                    style:
                        TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),
                  ),
                  //   Theme.of(context).textTheme.displayLarge,
                  // ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Text(
                    AppStrings.pleaseChooseYourLanguage.tr(context),
                    style:
                    TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),
                    // style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  BlocBuilder<GlobalCubit, GlobalState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          CustomButton(
                            text: 'English',
                            onPressed: () {
                              BlocProvider.of<GlobalCubit>(context).changeLang('en');
                                                            navigate(context: context, route: Routes.login);

                            },
                            width: 140,
                            background: AppColors.black,
                          ),
                          const Spacer(),
                          CustomButton(
                            text: 'العربية',
                            onPressed: () {
                              BlocProvider.of<GlobalCubit>(context).changeLang('ar');
                              navigate(context: context, route: Routes.login);
                            },
                            width: 140,
                            background: AppColors.black,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
