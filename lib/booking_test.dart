import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageSiteState createState() => _BookingPageSiteState();
}

class _BookingPageSiteState extends State<BookingPage> {
  //quantity
  int quantityCount = 0;

  //text field
  String userName = '';
  String userAddress = '';
  String userPhone = '';
  String userEmail = '';
  DateTime? reservationDateTime;
  String additionalRequests = '';

  //form key
  final _formKey = GlobalKey<FormState>();

  //decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  //increment quantity
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        reservationDateTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        reservationDateTime = DateTime(
          reservationDateTime!.year,
          reservationDateTime!.month,
          reservationDateTime!.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
        title: const Text('Booking Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //text field name
                    TextFormField(
                      onChanged: (value) {
                        userName = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    //text field address
                    TextFormField(
                      onChanged: (value) {
                        userAddress = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    //text field phone number
                    TextFormField(
                      onChanged: (value) {
                        userPhone = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone No',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    //text field email
                    TextFormField(
                      onChanged: (value) {
                        userEmail = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                                r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    //text field date and time
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              reservationDateTime == null
                                  ? 'Select Date'
                                  : 'Date: ${DateFormat('dd/MM/yyyy').format(reservationDateTime!)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextButton(
                            onPressed: () => _selectTime(context),
                            child: Text(
                              reservationDateTime == null
                                  ? 'Select Time'
                                  : 'Time: ${DateFormat('hh:mm a').format(reservationDateTime!)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),

                    c

                    const SizedBox(height: 20),

                    //price + quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        const Text(
                          "Guest:",
                          style: TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),

                        //quantity
                        Row(
                          children: [
                            //minus button
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 123, 70, 66),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                onPressed: decrementQuantity,
                              ),
                            ),

                            //quantity button
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  quantityCount.toString(),
                                  style: const TextStyle(
                                    //color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                            //plus button
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 123, 70, 66),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: incrementQuantity,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // If the form is valid, proceed with booking
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Booking"),
                  content: const Text(
                      "Are you sure you want to submit the booking details?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/intropage');
                      },
                      child: const Text("Confirm"),
                    )
                  ],
                );
              },
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 123, 70, 66),
              borderRadius: BorderRadius.circular(40)),
          //padding: const EdgeInsets.all(20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text
              Text(
                "Let's Booking",
                style: TextStyle(color: Colors.white),
              ),

              //SizedBox(height: 25),

              //icon
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: BookingPage(),
    ),
  ));
}

