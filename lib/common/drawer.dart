import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("AppMaking.co"),
              accountEmail: Text("sundar@appmaking.co"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?size=626&ext=jpg&ga=GA1.1.1395880969.1709769600&semt=sph",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading:const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.grid_3x3_outlined),
              title: const Text("Products"),
              onTap: () {},
            ),
            ListTile(
          leading: const Icon(Icons.category_outlined),
          title: const Text("Categories"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text("Cart"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.delivery_dining),
          title: const Text("My Orders"),
          onTap: () {},
        ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () {},
            )
          ],
        )
    );
  }
}