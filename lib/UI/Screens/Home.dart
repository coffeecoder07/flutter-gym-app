import 'package:flutter/material.dart';
import 'package:gymapp/Providers/DataProvider.dart';
import 'package:gymapp/Providers/LocationProvider.dart';
import 'package:gymapp/UI/Components/MainCard.dart';
import 'package:gymapp/UI/Components/NoPermission.dart';
import 'package:gymapp/UI/Components/SearchComponent.dart';
import 'package:gymapp/UI/Screens/ErrorScreen.dart';
import 'package:gymapp/UI/Screens/Search.dart';
import 'package:gymapp/UI/Widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import '../../Models/GymModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  int page = 1;
  bool noMoreData = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          noMoreData == false) {
        final dataProvider = Provider.of<DataProvider>(context, listen: false);
        final locationProvider =
            Provider.of<LocationProvider>(context, listen: false);
        locationProvider.locationDataModel.then((value) {
          final position = value.position;
          if (position != null) {
            dataProvider
                .loadMoreData(
                    lat: position.longitude,
                    lng: position.longitude,
                    page: page + 1)
                .then((value) {
              if (value) {
                page++;
              }
              else {
                noMoreData = true;
                dataProvider.notifyListeners();
              }
            });
          }
        });

        // postProvider.pageNumber = postProvider.pageNumber + 1;
        // postProvider.getAllPosts();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          size: 130,
          titleWidget:
              Consumer<LocationProvider>(builder: (_, locationProvider, child) {
            return FutureBuilder(
                future: locationProvider.locationDataModel,
                builder: (_, AsyncSnapshot<LocationDataModel> snapShot) {
                  final locality = snapShot.data?.placeMark?[0].locality;
                  final area = snapShot.data?.placeMark?[0].administrativeArea;
                  final status = snapShot.data?.locationStatus;
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Text("...");
                  } else if (snapShot.hasError) {
                    return const Text("Something Went Wrong.");
                  }
                  return InkWell(
                    borderRadius: BorderRadius.circular(1000),
                    onTap: () {
                      showSearch(
                          context: context, delegate: SearchView(list: []));
                    },
                    child: SizedBox(
                      width: 150,
                      height: 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (status == LocationStatus.active)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  locality ?? "Unavailable",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          if (status == LocationStatus.active)
                            Text(
                              area ?? "Unavailable",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          if (status == LocationStatus.permissionDenied ||
                              status == LocationStatus.permissionDeniedForever)
                            const Text(
                              "Permission Denied",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          if (status == LocationStatus.serviceNotAvailable)
                            const Text(
                              "Not Available",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                  );
                });
          }),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: SearchComponent(
            //     onTap: () {
            //   showSearch(context: context, delegate: SearchView(list: []));
            // }
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 2000), () {});
          },
          child:
              Consumer<LocationProvider>(builder: (_, locationProvider, child) {
            return FutureBuilder(
                future: locationProvider.locationDataModel,
                builder: (_, AsyncSnapshot<LocationDataModel> snapShot) {
                  final status = snapShot.data?.locationStatus;
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  else if (status == LocationStatus.permissionDenied) {
                    // request PermissionAgain
                    return NoPermission(
                        label: "Allow Access",
                        heading: 'Location Permission',
                        description:
                            'We need to request your permission to read your Location in order to load it in the app.',
                        onPressed: () {
                          locationProvider.openAppSettings();
                        });
                  }
                  else if (status == LocationStatus.permissionDeniedForever) {
                    // open App Settings
                    return NoPermission(
                        label: "Open App Settings",
                        heading: 'Location Permission',
                        description:
                            'You need to give this permission from the system settings.',
                        onPressed: () {
                          locationProvider.openAppSettings();
                        });
                  }
                  else if (status == LocationStatus.serviceNotAvailable) {
                    // open App Settings
                    return NoPermission(
                        label: "Open Location Settings",
                        heading: 'Location Service',
                        description:
                            'You need to Turn on the Device Location from the system settings.',
                        onPressed: () {
                          locationProvider.openLocationSettings();
                        });
                  }
                  else if (snapShot.hasError) {
                    return const ErrorScreen();
                  }
                  return Consumer<DataProvider>(
                      builder: (_, dataProvider, child) {
                    return FutureBuilder(
                        future: dataProvider.gyms,
                        builder: (_, AsyncSnapshot<List<GymModel>> snapShot) {
                          final gyms = snapShot.data;
                          if (snapShot.hasData && gyms != null) {
                            return ListView.separated(
                              controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                itemBuilder: (_, index) {
                                  if (index == gyms.length && noMoreData==false) {
                                    return SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  else if(index == gyms.length && noMoreData==true){
                                    return const SizedBox();
                                  }
                                  return MainCard(
                                    gym: gyms[index],
                                  );
                                },
                                separatorBuilder: (_, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: gyms.length+1);
                          } else if (snapShot.hasError) {
                            return const ErrorScreen();
                          } else if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          }
                          return const Center(
                            child: Text("No data Found"),
                          );
                        });
                  });
                });
          }),
        ));
  }
}
