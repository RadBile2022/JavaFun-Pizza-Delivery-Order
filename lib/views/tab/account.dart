
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();

}

class _AccountState  extends State<Account>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Wahyu Wiradarma'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://api-portfolio.gft.academy/storage/images/profilePicture_1675396879415.jpg'),
            ),
            accountEmail: Text('wahradar511@gmail.com'),
          ),
          DrawerListTile(
            iconData: Icons.settings,
            title: 'Settings',
            onTilePressed: () {},
          ),

          DrawerListTile(
            iconData: Icons.lock,
            title: 'Migrate to Pro',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.policy,
            title: 'Syarat dan Ketentuan',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.star_rate,
            title: 'Beri Rating',
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.help_center,
            title: 'Pusat Bantuan',
            onTilePressed: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.red),
            title: Text('Keluar', style: TextStyle(color: Colors.red, fontSize: 16),),
            onTap: (){},
          )


        ],
      ),
    );
  }

}

class DrawerListTile extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final VoidCallback? onTilePressed;

  const DrawerListTile({Key? key, this.iconData, this.title, this.onTilePressed}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title!,style: TextStyle(fontSize: 16),
      ),
    );
  }}