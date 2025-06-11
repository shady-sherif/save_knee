import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/features/home/views/widgets/vid_list.dart';
import 'package:save_knee_23/features/payment_screen/payment_screen.dart';
import '../../../auth/auth_cubit/auth_cubit.dart';
import 'ExcVidList.dart';
import 'custom_home_view_app_bar.dart';
import 'doctor_container.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<Color> colorList = [
    const Color(0xffd4a373),
    const Color(0xffbc6c25),
    const Color(0xffccd5ae),
    const Color(0xfff4a261),
    const Color(0xff99582a),
    const Color(0xff457b9d),
    const Color(0xff9e2a2b),
    const Color(0xff6c584c),
  ];

  @override
  Widget build(BuildContext context) {
    var auth = AuthCubit.get(context);
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, currentState) =>
          currentState is ImageInitial ||
          currentState is ImageFailure ||
          currentState is ImageLoaded ||
          currentState is DoctorsListLoaded,
      builder: (_, state) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const CustomHomeViewAppBar(),
                  SizedBox(
                    height: size.height * .06,
                  ),
                  VidList(
                      height: size.height * .2,
                      label: 'Continue Exercising',
                      hasSeeAllButton: false,
                      tile: const ExcVidList()),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 7),
                    child: Text(
                      'Choose Your Doctor',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: auth.doctorsList.length,
                      itemBuilder: (_, index) {
                        final colorIndex = index % colorList.length;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DoctorContainer(
                            color: colorList[colorIndex],
                            doctorModel: auth.doctorsList[index],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor
                      ),
                      child: const Text(
                        'Book Appointment',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return const AppointmentScreen();
                      })),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
