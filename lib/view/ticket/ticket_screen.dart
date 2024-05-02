import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';
import 'package:movie_app/view/payement/payement_screen.dart';

class TicketScreen extends StatefulWidget {
  final String title;
  final String date;
  const TicketScreen({super.key, required this.title, required this.date});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int selectDate = 0;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(widget.title),
            Text(
              'In the Theatres: ${widget.date}',
              style: const TextStyle(fontSize: 16, color: Color(0xff61C3F2)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Date',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: ((context, index) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectDate = index;
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: selectDate == index
                                    ? const Color(0xff61C3F2)
                                    : const Color(0xffEFEFEF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '$index mar',
                              style: TextStyle(
                                  color:
                                      selectDate == index ? Colors.white : null,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    );
                  })),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '12:30',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Cinetech + Hall')
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: selectedIndex == index
                                          ? const Color(0xff61C3F2)
                                          : const Color(0xffEFEFEF),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset('assets/images/seats.png')),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('From '),
                                Text(
                                  '\$50',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(' or '),
                                Text(
                                  '2500',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {
                Get.to(() =>
                    PayementScreen(title: widget.title, date: widget.date));
              },
              title: 'Select Seat',
              backgroundColor: const Color(0xff61C3F2),
            )
          ],
        ),
      ),
    );
  }
}
