import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'color_constants.dart';

void main() {
  runHomeApp();
}

void runHomeApp() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Assignment',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.fontColor),
        ),
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
  int _carouselIndex = 0;
  int _selectedDateIndex = 3;
  int _navIndex = 0;

  final List<Map<String, dynamic>> _dates = [
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
      
      backgroundColor: AppColors.background,
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.navy,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildTopBar(),
              const SizedBox(height: 18),
              _buildWelcomeRow(),
              const SizedBox(height: 18),
              _buildCarousel(),
              const SizedBox(height: 12),
              _buildPageIndicator(),
              const SizedBox(height: 18),
              _buildTimelineHeader(),
              const SizedBox(height: 16),
              _buildDateStrip(),
              const SizedBox(height: 18),
              _buildActivityCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _circleIconButton(
            child: SvgPicture.asset(
              'assets/icons/icon_menu.svg',
              width: 14,
              height: 14,
            ),
          ),
          const Spacer(),
          _circleIconButton(
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
              _circleIconButton(
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
                    color: AppColors.orange,
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
              boxShadow: _softShadow(),
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

  Widget _buildWelcomeRow() {
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
                    color: AppColors.navy,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'here is your dashboard....',
                  style: TextStyle(
                    color: AppColors.subtitle,
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
              boxShadow: _softShadow(),
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

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: PageView(
        onPageChanged: (index) => setState(() => _carouselIndex = index),
        children: [
          _ordersCard(),
          _subscriptionsCard(),
          _customersCard(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final selected = _carouselIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: selected ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: selected ? AppColors.navy : AppColors.subtitle,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _ordersCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cyanBlue,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 8,
              top: 4,
              child: SvgPicture.asset(
                'assets/icons/orders_illustration.svg',
                width: 132,
                height: 132,
              ),
            ),
            Positioned(
              left: 16,
              bottom: 14,
              child: _pillButton('Orders', AppColors.orange),
            ),
            Positioned(
              right: 10,
              top: 14,
              child: _statChip(
                color: AppColors.orange,
                textColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        children: [
                          TextSpan(text: 'You have '),
                          TextSpan(
                            text: '3',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(text: ' active\norders from'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _avatarStack(
                      [
                        'assets/images/person1.jpg',
                        'assets/images/person2.jpg',
                        'assets/images/person3.jpg',
                      ],
                      borderColor: const Color(0xFFFF9A74),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 12,
              child: _statChip(
                color: Colors.white,
                textColor: AppColors.navy,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: '02',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(text: ' Pending\nOrders from'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _avatarStack(
                      [
                        'assets/images/person4.jpg',
                        'assets/images/person5.jpg',
                      ],
                      borderColor: AppColors.cyanBlue,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subscriptionsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gold,
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
              child: _pillButton('Subscriptions', AppColors.royalBlue),
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
                      _statChip(
                        color: AppColors.royalBlue,
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
                        child: _avatarStack(
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
                  _statChip(
                    color: Colors.white,
                    textColor: AppColors.navy,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.iconGrey,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: '10',
                            style: TextStyle(
                              color: AppColors.navy,
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
                  _statChip(
                    color: Colors.white,
                    textColor: AppColors.navy,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.iconGrey,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: '119',
                            style: TextStyle(
                              color: AppColors.navy,
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

  Widget _customersCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.brightGreen,
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
              child: _pillButton('View Customers', AppColors.magenta),
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
                      _statChip(
                        color: AppColors.magenta,
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
                            _avatarStack(
                              [
                                'assets/images/person3.jpg',
                                'assets/images/person1.jpg',
                                'assets/images/person2.jpg',
                              ],
                              borderColor: AppColors.brightGreen,
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
                                color: AppColors.iconGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _statChip(
                    color: Colors.white,
                    textColor: AppColors.navy,
                    width: 136,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '1.8%',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_upward,
                              size: 16,
                              color: AppColors.brightGreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 26,
                          width: 100,
                          child: CustomPaint(painter: _SparklinePainter()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _statChip(
                    color: Colors.white,
                    textColor: AppColors.navy,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: AppColors.iconGrey,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: '10',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(text: ' Active\nCustomers'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        _avatarStack(
                          [
                            'assets/images/person4.jpg',
                            'assets/images/person5.jpg',
                            'assets/images/person1.jpg',
                          ],
                          borderColor: AppColors.brightGreen,
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

  Widget _buildTimelineHeader() {
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
                    color: AppColors.subtitle,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Today',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _outlineChip(
            child: const Row(
              children: [
                Text(
                  'TIMELINE',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.navy,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _outlineChip(
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
                    color: AppColors.navy,
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

  Widget _buildDateStrip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_dates.length, (index) {
          final selected = index == _selectedDateIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = index),
            child: Column(
              children: [
                Text(
                  _dates[index]['day'] as String,
                  style: TextStyle(
                    color: selected ? AppColors.darkTeal : AppColors.subtitle,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _dates[index]['date'] as String,
                  style: TextStyle(
                    color: selected ? AppColors.darkTeal : AppColors.subtitle,
                    fontSize: 16,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.darkTeal : Colors.transparent,
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

  Widget _buildActivityCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: _softShadow(),
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
                      color: AppColors.navy,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'New Order created with Order',
                    style: TextStyle(
                      color: AppColors.subtitle,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '09:00 AM',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.orange.withValues(alpha: 0.85),
                  ),
                ],
              ),
            ),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.orange,
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

  Widget _buildBottomNav() {
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
              child: _navItem(
                0,
                'assets/icons/nav_home.svg',
                'Home',
              ),
            ),
            Expanded(
              child: _navItem(
                1,
                'assets/icons/nav_customers.svg',
                'Customers',
              ),
            ),
            const SizedBox(width: 56),
            Expanded(
              child: _navItem(
                2,
                'assets/icons/nav_khata.svg',
                'Khata',
              ),
            ),
            Expanded(
              child: _navItem(
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

  Widget _navItem(int index, String asset, String label) {
    final selected = _navIndex == index;
    final color = selected ? AppColors.navy : AppColors.iconGrey;
    return InkWell(
      onTap: () => setState(() => _navIndex = index),
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

  Widget _circleIconButton({required Widget child}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: _softShadow(),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _pillButton(String label, Color color) {
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

  Widget _statChip({
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

  Widget _outlineChip({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: _softShadow(),
      ),
      child: child,
    );
  }

  Widget _avatarStack(
    List<String> paths, {
    required Color borderColor,
    double size = 20,
  }) {
    return SizedBox(
      height: size,
      width: size + (paths.length - 1) * (size * 0.65),
      child: Stack(
        children: List.generate(paths.length, (index) {
          return Positioned(
            left: index * (size * 0.65),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 1.5),
                image: DecorationImage(
                  image: AssetImage(paths[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<BoxShadow> _softShadow() {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ];
  }
}

class _SparklinePainter extends CustomPainter {
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
        ..color = AppColors.brightGreen.withValues(alpha: 0.25)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.brightGreen
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
