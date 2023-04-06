import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (_, model, __) => Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey[500], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('Class member : Plattinum',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey[500], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('Name : Mr.Furni Store',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey[500], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('User Type : Customer',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
          ),
        ),          
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey[500], borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('Address : 99/9 jk Roads, Cheangkrue Sakon Nakhon, 47000',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
          ),
        ),        
                  
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: MainButton(
                text: 'Log Out',
                onTap: () {
                  _logout(model, context);
                }),
          ),
        ],
      ),
    );
  }
}
