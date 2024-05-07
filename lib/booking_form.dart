import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  //quantity
  int quantityCount = 1;

  //decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
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

  //text field
  String userName = '';
  String userAddress = '';
  String userPhone = '';
  String userEmail = '';
  DateTime? reservationDateTime;
  String additionalRequests = '';

  String? validateGuests(int value) {
    if (value == 0) {
      return 'Number of guests cannot be zero!';
    }
    return null;
  }

  //submit button
  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Booking'),
          content: const Text(
              "Are you sure you want to submit the booking details?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Call your submission function here
                //_formKey.currentState?.save();
                // Call _showDetailsDialog when the user confirms
                _showDetailsDialog(_submit);
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  //display all input alert box
  void _showDetailsDialog(Function() submitFunction) {
  final isValid = _formKey.currentState?.validate();
  if (!isValid!) {
    return;
  }

  // Show confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Booking'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: $userName'),
            Text('Address: $userAddress'),
            Text('Phone No: $userPhone'),
            Text('E-Mail: $userEmail'),
            if (reservationDateTime != null)
              Text('Date & Time: ${DateFormat('dd/MM/yyyy hh:mm a').format(reservationDateTime!)}'),
            if (additionalRequests.isNotEmpty)
              Text('Additional Requests: $additionalRequests'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Call your submission function here
              _formKey.currentState?.save();
            },
            child: Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
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
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //form
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //text input name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  userName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your name!';
                  }
                  return null;
                },
              ),

              //text input address
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  userAddress = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your address!';
                  }
                  return null;
                },
              ),

              //text input phone number
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone No'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  userPhone = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your phone number!';
                  }
                  return null;
                },
              ),

              //text input email
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  userEmail = value;
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

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

              //text field decoration
              TextField(
                onChanged: (value) {
                  additionalRequests = value;
                },
                decoration: InputDecoration(
                  labelText: 'Additional Requests',
                ),
              ),

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

              //guest validation message
              if (quantityCount == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Number of guests cannot be zero!',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),

              //button
              Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 65.0, vertical: 10.0),
                    minimumSize: const Size(
                        30, 15),
                    backgroundColor: Colors.brown, // 👈 Change this according to your requirement
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () => _submit(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
