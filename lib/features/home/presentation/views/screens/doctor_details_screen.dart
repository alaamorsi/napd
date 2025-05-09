import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/features/authorization/data/models/user_model.dart';
import 'package:nabd/features/chats/presentation/view_models/cubit.dart';
import 'package:nabd/features/chats/presentation/views/screens/chat_details_screen.dart';
import 'package:nabd/features/home/presentation/views/widgets/build_doc_details_card.dart';

import '../../../../../core/colors/constant_colors.dart';
import '../../../../../core/styles/constant_styles.dart';
import '../../../../../core/widgets/default_home_appbar.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final UserModel doctorModel;
  const DoctorDetailsScreen({super.key, required this.doctorModel});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppbar(
        title: 'تفاصيل الطبيب',
        canBack: true,
        backFunction: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BuildDocDetailsCard(doctorModel: widget.doctorModel),
            SizedBox(height: 30.0.h),
            Text('معلومات عن الطبيب', style: ConstantStyles.subtitle),
            SizedBox(height: 10.0.h),
            Text(
              widget.doctorModel.about,
              style: ConstantStyles.body,
              textAlign: TextAlign.end,
              maxLines: isExpanded ? null : 2,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Removes extra space
                minimumSize: const Size(0, 0), // Ensures no minimum size
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Reduces touch area
              ),
              child: Text(
                isExpanded ? 'اقل' : 'المزيد',
                style: ConstantStyles.body.copyWith(
                  color: ConstantColors.primaryColor,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
               
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ChatCubit(),
                      child: ChatDetailsScreen(
                        name: widget.doctorModel.name,
                        receiverId: widget.doctorModel.uId,
                        imageUrl: widget.doctorModel.image,
                      ),
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  ConstantColors.primaryColor,
                ),
                fixedSize: WidgetStatePropertyAll(
                  Size(double.maxFinite, 50.0.h),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_outlined, size: 24.0.r, color: Colors.white),
                  SizedBox(width: 10.0.w),
                  Text(
                    'بدأ الدردشة',
                    style: ConstantStyles.title.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
          ],
        ),
      ),
    );
  }
}
