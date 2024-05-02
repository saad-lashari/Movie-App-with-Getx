import 'package:flutter/material.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';

class PayementScreen extends StatelessWidget {
  final String title;
  final String date;
  const PayementScreen({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title),
            Text(
              'In the Theatres: $date',
              style: const TextStyle(fontSize: 16, color: Color(0xff61C3F2)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/seats.png',
              height: 300,
              width: 500,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/seat.png',
                  height: 30,
                  color: Colors.yellow,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Selected',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 40,
                ),
                Image.asset(
                  'assets/images/seat.png',
                  height: 30,
                  color: Colors.black54,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Not Available',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/seat.png',
                  height: 30,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'VIP(\$50)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 40,
                ),
                Image.asset(
                  'assets/images/seat.png',
                  height: 30,
                  color: const Color(0xff61C3F2),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Regular (\$50)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xffEFEFEF),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('4/3 row X',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text('Total Price',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text('\$50',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600))
                  ],
                ),
                Expanded(
                  child: CustomButton(
                    title: 'Proceed to Pay',
                    backgroundColor: Color(0xff61C3F2),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
