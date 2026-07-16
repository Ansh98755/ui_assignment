import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'color_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Assignment',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: MyColors.bg,
        primaryColor: MyColors.darkBlue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  int selectedDay = 3;
  int currentTab = 0;

  final List<Map<String, dynamic>> weekList = [
    {'day': 'MON', 'date': '20'},
    {'day': 'TUE', 'date': '21'},
    {'day': 'WED', 'date': '22'},
    {'day': 'THU', 'date': '23'},
    {'day': 'FRI', 'date': '24'},
    {'day': 'SAT', 'date': '25'},
    {'day': 'SUN', 'date': '26'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bg,
      // center fab
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: MyColors.darkBlue,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              topBar(),
              const SizedBox(height: 18),
              welcomeSection(),
              const SizedBox(height: 18),
              bannerPager(),
              const SizedBox(height: 12),
              pageDots(),
              const SizedBox(height: 18),
              todayHeader(),
              const SizedBox(height: 16),
              daysRow(),
              const SizedBox(height: 18),
              newOrderCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          circleBtn(
            child: SvgPicture.asset(
              'assets/icons/icon_menu.svg',
              width: 14,
              height: 14,
            ),
          ),
          const Spacer(),
          circleBtn(
            child: SvgPicture.asset(
              'assets/icons/icon_heart.svg',
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            clipBehavior: Clip.none,
            children: [
              circleBtn(
                child: SvgPicture.asset(
                  'assets/icons/icon_bell.svg',
                  width: 16,
                  height: 18,
                ),
              ),
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: MyColors.accentOrange,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: softShadow(),
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile_main.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Mypcot !!',
                  style: TextStyle(
                    color: MyColors.darkBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'here is your dashboard....',
                  style: TextStyle(
                    color: MyColors.greyText,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: softShadow(),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/icon_search.svg',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerPager() {
    return SizedBox(
      height: 230,
      child: PageView(
        clipBehavior: Clip.none,
        onPageChanged: (index) => setState(() => currentPage = index),
        children: [
          ordersBanner(),
          subscriptionBanner(),
          customersBanner(),
        ],
      ),
    );
  }

  Widget pageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final selected = currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: selected ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: selected ? MyColors.darkBlue : MyColors.greyText,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  // card with faces hanging out the bottom
  Widget floatCard({
    required Color color,
    required Widget child,
    required List<String> pics,
    required Color picBorder,
    double picSize = 26,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: child,
        ),
        Positioned(
          bottom: -(picSize * 0.55),
          child: profileStack(pics, borderColor: picBorder, size: picSize),
        ),
      ],
    );
  }

  Widget ordersBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
      child: SizedBox(
        height: 210,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.bannerBlue,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/orders_illustration.svg',
                      width: 92,
                      height: 92,
                    ),
                  ),
                  const SizedBox(height: 10),
                  filledBtn('Orders', MyColors.burntOrange),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: -6,
              width: 148,
              child: floatCard(
                color: MyColors.burntOrange,
                picBorder: const Color(0xFFE85A3C),
                pics: const [
                  'assets/images/person1.jpg',
                  'assets/images/person2.jpg',
                  'assets/images/person3.jpg',
                ],
                picSize: 28,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.25,
                    ),
                    children: [
                      TextSpan(text: 'You have '),
                      TextSpan(
                        text: '3',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(text: ' active\norders from'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 14,
              bottom: 8,
              width: 148,
              child: floatCard(
                color: Colors.white,
                picBorder: const Color(0xFFE85A3C),
                pics: const [
                  'assets/images/person4.jpg',
                  'assets/images/person5.jpg',
                ],
                picSize: 28,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: MyColors.greyText,
                      fontSize: 12,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: '02',
                        style: TextStyle(
                          color: MyColors.darkBlue,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(text: ' Pending\n'),
                      TextSpan(
                        text: 'Orders from',
                        style: TextStyle(
                          color: MyColors.darkBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscriptionBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.bannerYellow,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 6,
              top: 2,
              child: SvgPicture.asset(
                'assets/icons/subscriptions_illustration.svg',
                width: 138,
                height: 120,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 14,
              child: filledBtn('Subscriptions', MyColors.deepBlue),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      infoBox(
                        color: MyColors.deepBlue,
                        textColor: Colors.white,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            children: [
                              TextSpan(
                                text: '03',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(text: ' deliveries'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: -12,
                        child: profileStack(
                          [
                            'assets/images/person1.jpg',
                            'assets/images/person2.jpg',
                            'assets/images/person3.jpg',
                          ],
                          borderColor: const Color(0xFF8AA0F5),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  infoBox(
                    color: Colors.white,
                    textColor: MyColors.darkBlue,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: MyColors.lightGrey,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: '10',
                            style: TextStyle(
                              color: MyColors.darkBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(text: ' Active\nSubscriptions'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  infoBox(
                    color: Colors.white,
                    textColor: MyColors.darkBlue,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: MyColors.lightGrey,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: '119',
                            style: TextStyle(
                              color: MyColors.darkBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(text: ' Pending\nDeliveries'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customersBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.bannerGreen,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 8,
              top: 2,
              child: SvgPicture.asset(
                'assets/icons/customers_illustration.svg',
                width: 132,
                height: 132,
              ),
            ),
            Positioned(
              left: 14,
              bottom: 14,
              child: filledBtn('View Customers', MyColors.pink),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      infoBox(
                        color: MyColors.pink,
                        textColor: Colors.white,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            children: [
                              TextSpan(
                                text: '15',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(text: ' New customers'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        bottom: -14,
                        child: Row(
                          children: [
                            profileStack(
                              [
                                'assets/images/person3.jpg',
                                'assets/images/person1.jpg',
                                'assets/images/person2.jpg',
                              ],
                              borderColor: MyColors.bannerGreen,
                              size: 22,
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 14,
                                color: MyColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  infoBox(
                    color: Colors.white,
                    textColor: MyColors.darkBlue,
                    width: 136,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '1.8%',
                              style: TextStyle(
                                color: MyColors.darkBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_upward,
                              size: 16,
                              color: MyColors.bannerGreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 26,
                          width: 100,
                          child: CustomPaint(painter: GraphPainter()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  infoBox(
                    color: Colors.white,
                    textColor: MyColors.darkBlue,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: MyColors.lightGrey,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: '10',
                                style: TextStyle(
                                  color: MyColors.darkBlue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(text: ' Active\nCustomers'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        profileStack(
                          [
                            'assets/images/person4.jpg',
                            'assets/images/person5.jpg',
                            'assets/images/person1.jpg',
                          ],
                          borderColor: MyColors.bannerGreen,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget todayHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'January, 23 2021',
                  style: TextStyle(
                    color: MyColors.greyText,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Today',
                  style: TextStyle(
                    color: MyColors.darkBlue,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          whiteChip(
            child: const Row(
              children: [
                Text(
                  'TIMELINE',
                  style: TextStyle(
                    color: MyColors.darkBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: MyColors.darkBlue,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          whiteChip(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/icon_calendar.svg',
                  width: 12,
                  height: 13,
                ),
                const SizedBox(width: 6),
                const Text(
                  'JAN, 2021',
                  style: TextStyle(
                    color: MyColors.darkBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget daysRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(weekList.length, (index) {
          final selected = index == selectedDay;
          return GestureDetector(
            onTap: () => setState(() => selectedDay = index),
            child: Column(
              children: [
                Text(
                  weekList[index]['day'] as String,
                  style: TextStyle(
                    color: selected ? MyColors.selectedGreen : MyColors.greyText,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  weekList[index]['date'] as String,
                  style: TextStyle(
                    color: selected ? MyColors.selectedGreen : MyColors.greyText,
                    fontSize: 16,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: selected ? MyColors.selectedGreen : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget newOrderCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: softShadow(),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New order created',
                    style: TextStyle(
                      color: MyColors.darkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'New Order created with Order',
                    style: TextStyle(
                      color: MyColors.greyText,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '09:00 AM',
                    style: TextStyle(
                      color: MyColors.accentOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: MyColors.accentOrange.withValues(alpha: 0.85),
                  ),
                ],
              ),
            ),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: MyColors.accentOrange,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/order_new_badge.svg',
                width: 30,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: bottomItem(
                0,
                'assets/icons/nav_home.svg',
                'Home',
              ),
            ),
            Expanded(
              child: bottomItem(
                1,
                'assets/icons/nav_customers.svg',
                'Customers',
              ),
            ),
            const SizedBox(width: 56),
            Expanded(
              child: bottomItem(
                2,
                'assets/icons/nav_khata.svg',
                'Khata',
              ),
            ),
            Expanded(
              child: bottomItem(
                3,
                'assets/icons/nav_orders.svg',
                'Orders',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomItem(int index, String asset, String label) {
    final selected = currentTab == index;
    final color = selected ? MyColors.darkBlue : MyColors.lightGrey;
    return InkWell(
      onTap: () => setState(() => currentTab = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            child: SvgPicture.asset(asset, width: 20, height: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBtn({required Widget child}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: softShadow(),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget filledBtn(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget infoBox({
    required Color color,
    required Color textColor,
    required Widget child,
    double? width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: textColor),
        child: child,
      ),
    );
  }

  Widget whiteChip({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: softShadow(),
      ),
      child: child,
    );
  }

  Widget profileStack(
    List<String> paths, {
    required Color borderColor,
    double size = 20,
  }) {
    const step = 0.72;
    return SizedBox(
      height: size,
      width: size + (paths.length - 1) * (size * step),
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(paths.length, (i) {
          return Positioned(
            left: i * (size * step),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 1.8),
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  paths[i],
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<BoxShadow> softShadow() {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ];
  }
}

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width * 0.15, size.height * 0.45)
      ..lineTo(size.width * 0.3, size.height * 0.6)
      ..lineTo(size.width * 0.45, size.height * 0.25)
      ..lineTo(size.width * 0.6, size.height * 0.5)
      ..lineTo(size.width * 0.75, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.35);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..color = MyColors.bannerGreen.withValues(alpha: 0.25)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = MyColors.bannerGreen
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
