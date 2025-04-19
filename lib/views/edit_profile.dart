import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Goes back
                    },
                  ),
                ),
                const Spacer(),
                const Text(
                  "Edit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://s3-alpha-sig.figma.com/img/8cc6/1fc2/ff5dd4d4d429ae2647361da29aa68abc?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=OpWTIogjFn3pf8MOZtFqSj5YU5cZfiwFFnNnZqIGfk5SP9bAvREpCgGXak2VUw6XSbuw1fEb45VlcdK0JEpJutFjGq8rso47rLLICvgXsaenfN0E1kT7n8xakGEuSG4TjBfRcFUiU2SQb7AUtFxCTxD5b8XwvucsVsplI0zsYvmsPCc73Oo5rJQn5C9dGJQKLycfMc1F1MFBVSAC-lrn7SXuuJqKtB7yL5IC0hUIVEo41Avahpkonf~uupAx5RZOOu4r3HwDFZkynjVnsYBjMJuBK77wqtDYNhGvVZrMawsN8kmBC9uIZ9tGHhWG8IlDc5UT~LzCOWh~sJuWLStPJA__",
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text("Name"),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Narasimha",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Mobile Number"),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "9898989898",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Email"),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Narasimha@gmail.com",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF1E0AFE),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
