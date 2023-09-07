import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymapp/Models/GymModel.dart';

import 'CustomButton.dart';

class MainCard extends StatelessWidget {
  final GymModel gym;
  final cardBackgroundColor = const Color(0xff1d1d1d);

  const MainCard({super.key,required this.gym});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: cardBackgroundColor),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.network(
                    gym.coverImage??'https://media.istockphoto.com/id/1322158059/photo/dumbbell-water-bottle-towel-on-the-bench-in-the-gym.jpg?s=612x612&w=0&k=20&c=CIdh6LPGwU6U6lbvKCdd7LcppidaYwcDawXJI-b0yGE=',
                    fit: BoxFit.cover,
                  ),
                )),
                Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // alignment: Alignment.center,
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://img.rawpixel.com/private/static/images/website/2022-05/rm218batch8-aum-03.jpg?w=1200&h=1200&dpr=1&fit=clip&crop=default&fm=jpg&q=75&vib=3&con=3&usm=15&cs=srgb&bg=F4F4F3&ixlib=js-2.2.1&s=632ad325675c5d12b2b781be9df2df0c',
                            ),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          gym.gymName??"Gym Name",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "${ gym.distance} km. ${gym.address1} ${gym.address2} ${gym.city}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "STARTING AT ₹ 1899/month",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                        label: 'FREE FIRST DAY',
                        backgroundColor: Theme.of(context).primaryColor,
                            onTap: (){

                            },
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: CustomButton(
                        label: 'BUY NOW',
                        backgroundColor: Colors.grey,
                            onTap: (){

                            },
                      ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
