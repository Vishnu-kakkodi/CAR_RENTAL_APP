import 'package:car_rental_app/controllers/car_controller.dart';
import 'package:car_rental_app/models/car_model.dart';
import 'package:car_rental_app/providers/car_provider.dart';
import 'package:car_rental_app/services/api/car_service.dart';
import 'package:flutter/material.dart';

class CarDetailsScreen extends StatefulWidget {
  final String carId;
  const CarDetailsScreen({super.key, required this.carId});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late Future<Car> _carFuture;
  final CarController _controller = CarController(CarProvider(), CarService());

  @override
  void initState() {
    super.initState();
    _carFuture = _controller.getCarDetails(widget.carId);
  }

  // final List<String> carImages = [
  //   "https://s3-alpha-sig.figma.com/img/06d4/fe8c/f461f005be6452cea9ee09bfad0cf04c?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fox0dTIopd7qEPWzx0dUWPOmPoVuRk7PDq9cesb1g7XaOMXAskVZFlPne-yW8HPswtPM6KvlG~fWXQ703CLKayrXyvGTMoNGHinSxBljHQhFnftrkKHYmoXudNxXWJY8fPWVnLSPSL4mVOBm2qk5TWzECACkPZvqMyd~HMN-34jB8fWYxD~Thjwdmu1DV-QJ9OoIr5JdaGGOtVxA5vzHLLjy7Pu4acEbdQ7x4vMsPyDXfubgJq6h9Oiec5vqzPEjC3KB-MrBQp9oKKuRCD8iIW1x5aWinWftZEzot-857LMPz89LU0-rVS2-e1AVyEitxRH3njPN4RU18aG9kXnvkg__",
  //   "https://s3-alpha-sig.figma.com/img/dc72/929c/a3bc6b7f2b5391acfddb1b79ca16d8a6?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=PeHmXu4n60CnzOqYRHxW3G5EH7lHy~HEM7eQDG9gO3nmnmdhMC3zvT3AtvHWbNBx4oTseKMH7vzAgaDe~wBEl6CH2I8Ql0wTFixUrsqva7WKHJ3z2zgtpRuIjtFSGw13bKdqExPPam~iGBJ2mwxOWrmh9pqlg8jZzn2eLT2zfwS8jOkMYUws67ip~2AOlTvFDr0iqvZALwRq8gtuf6snKKpVCAYLWd5H6zfqjx0EdKOYNib3oSujgKoS0ySMuXFmBKPVL8lvoI-nE-7g475~Lo7dDiO-dxdlni7VL2O6eqmP1Rxf2sT--ROkDwxnwdD7GQW0W9paskZ1u90XUMFRpw__",
  //   "https://s3-alpha-sig.figma.com/img/38b7/0ec0/1c284800d34098d0c8c864a051164b1a?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=DRneyx7T1YGAampj6eLchSw51Mtdzad~P6ON6pvW3T7JdkHAjxa1wa4OzsoTmP~Z6MqPmZi6xVWY79rbTOs-3on9Yklntr4YGlLf-GLiMwdfUxoetJ53UPhzps6kGRxedEMd2C7nWNf4ChC~Uo6YJdWPhhmYMO2OpqYq7VTEZVjVNdZFi2oRZD-wNX2EhqCWsq6XnvMnOn87i5v0kb6LE~FU~3zPD~trBHjXa1r9f8j2m5JxuVBiyhpVW-WJwbQtJw~kxquH4FgfXztBrMPbZAi0oo-LP98qfPvRYijLz4iNg0ygx--vnP84tzzXJcAs7rvazSwEnxPwww7lz98zoA__",
  //   "https://s3-alpha-sig.figma.com/img/8018/07cb/3bc37d64e0018d0e260df56b3c2099cf?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=eXAsjnxBV2m8nOJLuonvVgHExBZF59XeSsxVMMgYACZkSGpyC-iWMsDHsSlmPAPQ0pN9I4GZy8ZenCGmb171vQq-qZVxMgPViaHfQFmStsKvdUwiZ-Q7Vg2MCsgta~9Wz1~xyTu-vV0jx9LJau5fyr6UpbOqOMNVspuc7UoA1wzQ-t3g8u~f5SAJgsWVneRqztc9dZz2QcoIZksm~C9t~RtG~BG3Lml2XF5X37-YiXyFcsWSntQDldS6fQGIHiJuq-Aicqw1ki0wsim7y8stne-rZxGeI7Zsgy65Ru1M7rWZ6x-5lOrAocEy59GX2R0BigXRJAjxFZzknHWj0SpU1g__",
  // ];

  int selectedImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('Car Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Car>(
        future: _carFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final car = snapshot.data!;
          final carImage = car.image;
          print(carImage);
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 257,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        carImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 60,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: 4,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImageIndex = index;
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  carImage,
                                  width: 63,
                                  height: 34,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 16),
        
              // Car Details
               Text(
                car.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
               Text(
                '${car.seats} seater | ${car.fuel} | ${car.type}',
                style: TextStyle(color: Colors.grey),
              ),
        
              const SizedBox(height: 16),
        
              // Uploaded Documents
              const Text(
                "Uploaded Documents",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 16),
        
              // Location & Time
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0XFF120698),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Hyderabad Bus stand, Kphb phase9, Kukatpally, Hyderabad',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "10:00 AM",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 2,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                Transform.translate(
                                  offset: const Offset(-5, 0),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "10:00 AM",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 20),
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Pickup location",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Pickup and return same location\nHyderabad Bus Stand, KPHB, Kukatpally",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 152,
                    height: 93,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/77d8/3866/6b389d6ccba22bf54d38042f2e7ee3e3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Ex9csb8IkFJrAgcSSWddKQTLdZ4MReezR6scrrLL8Q0CvIgJHqdgvUAKGjkHRe6xwxyoELntVykRJBUioQ3a1s35SxWPi7npqcD4s-5bJ4rvZuupQCITK6hU4jeu32fehiad3rViDHBl9YujWolZT45FOwEe~mbt3ZbRrY~6S2FVWGg~zCccALi6rVEgOyioEEiHzIs8I8arNWLxoMlTyp5k6I7vesdPY-ZMKGjCzel-duYmDo7NfrQweThNhMGbC~yQ2bfBN7K6QnWY6IJIZM-sFNPV9NEvumGPlJKfiezcxCwjn~MRuwy8osbc1PKPGl0bIwCydROOZy-MfqmE8Q__",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 16),
        
              // Security Deposit
              const Text(
                "Security Deposit",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Bike, Laptop, Cash",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
        
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Note: ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text:
                          'Submit the bike in uploaded rc same otherwise it is not Accepted',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 16),
        
              // Booking Details
              const Text(
                "Booking details",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("Price"), Text("₹ 1700")],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("Wallet"), Text("₹ 1700")],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "₹ 1500",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 80),
            ],
          ),
        );
  }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          "https://s3-alpha-sig.figma.com/img/0515/9dbe/5c5eae16ac8914c3cc0b19f1dc721c2b?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TW2GeARkUMivi7jcZAkvqckUlKVTBdt7Ul58CI6Vyhnd4vmFYjT8HoOUWmG-oMT4BLaO1V-dvYu2f8QJsXMassikULxE5Eu2Uc2NOORHi97Png0Qt6vzwKww2gf-3sYKCIOS4yIl-5wX7MC6swWdo9zl66zjxHZVSANiIHh3QktEYDqqjlPuv2PoaSR4~JAIhpg6koxYCIoknbx~nfkM9D9ITvvjZLAvCx44TzP-I2cliACiSlU2LwlLh0isFHvNGgo3yqbbHbZTBgMjZ1ZmISA~WY2uvLhtG1kLHdETA7--bs4SNct4E1wlt~UNbs-6MWt6KArKTgxPJmtC9rDLVg__",
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your Booking is confirmed',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: const Text("Apply"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0XFF120698),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            "Proceed",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
