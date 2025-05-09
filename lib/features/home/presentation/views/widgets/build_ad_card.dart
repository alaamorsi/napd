import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nabd/core/colors/constant_colors.dart';
import 'package:nabd/core/images/constant_images.dart';
import 'package:nabd/core/styles/constant_styles.dart';
import 'package:nabd/features/home/presentation/view_models/services/ad_controller.dart';

class BuildAdCard extends StatefulWidget {
  const BuildAdCard({super.key});

  @override
  State<BuildAdCard> createState() => _BuildAdCardState();
}

class _BuildAdCardState extends State<BuildAdCard> {
  late AdSliderController controller;

  final List<String> ads = [
    "استشر الأطباء مجانًا وأخبرهم بمشكلتك الصحية بسهولة",
    "لا تحتار بشأن صحتك تواصل مع الأطباء واحصل على نصيحة فورية",
    'هل تحتاج إلي استشارة طبية؟\n اسأل طبيبك الآن مجاناً'
  ];

  final List<String> adsImages = [
    ConstantImages.ad1,
    ConstantImages.ad2,
    ConstantImages.ad3,
  ];

  @override
  void initState() {
    super.initState();
    controller = AdSliderController(ads: ads, adsImages: adsImages);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170.0.h,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: ads.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Card(
                elevation: 0.0.w,
                color: ConstantColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ads[index], style: ConstantStyles.title,textDirection: TextDirection.rtl,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            width: 135.0.w,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(adsImages[index]),
                                  fit: BoxFit.cover,
                                ),
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
          ),
        ),
         SizedBox(height: 10.h),
        ValueListenableBuilder<int>(
          valueListenable: controller.currentIndex,
          builder: (context, current, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(ads.length, (i) {
                return Container(
                  margin:  EdgeInsets.symmetric(horizontal: 4.w),
                  width: 20.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    
                    color: i == current ? ConstantColors.primaryColor : Colors.grey,
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
