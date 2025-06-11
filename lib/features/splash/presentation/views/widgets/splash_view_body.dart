import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimationLogo;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      initSlidingAnimation();
      navigatingToHomeView();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          const Text(
            'Save Your Knee',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kPrimaryColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .19,
          ),
          Center(
            child: SlideTransition(
              position: slidingAnimationLogo,
              child: Image.asset(
                'assets/images/knee.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Spacer(),
          const Text('Loading.. please wait patiently'),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimationLogo =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
    slidingAnimationLogo.addListener(() {
      setState(() {});
    });
  }

  void navigatingToHomeView() {
    Future(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      if (context.mounted) {
        GoRouter.of(context).push(AppRouter.kLoginView);
      }
    });
  }
}
