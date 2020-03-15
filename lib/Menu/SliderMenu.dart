import 'package:flutter/material.dart';
import 'package:mybus/Menu/Ajuda.dart';
import 'package:mybus/Menu/Carteira.dart';
import 'package:mybus/Menu/Configuracoes.dart';
import 'package:mybus/Menu/EmpresaDetalhe.dart';

class SliderMenu extends StatefulWidget {
  @override
  _SliderMenuState createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  String _url =
      "https://optclean.com.br/wp-content/uploads/2018/04/eCrAxIc-1-770x347.jpg";
  String _mainProfilePicture =
      "https://scontent.fsdu15-1.fna.fbcdn.net/v/t31.0-8/s960x960/28827008_1435031969942079_3546758467376867058_o.jpg?_nc_cat=109&_nc_sid=85a577&_nc_eui2=AeEXc27ChU6n2R8ERqfaSwGl5q7ziYiDCHhemIozi2PE1V86umS9VFoWzQL7zVvXRqZSVAoGnLpZuhttUdgib1IMcPQcyGOpjW85PRHNhd4yfA&_nc_ohc=xOVX7S82b7cAX-w4yJR&_nc_ht=scontent.fsdu15-1.fna&_nc_tp=7&oh=5393fa62cebd4610a8888389310f068e&oe=5EB8FE1E";
  String _otherProfilePicture =
      "https://scontent.fsdu15-1.fna.fbcdn.net/v/t1.0-9/80558189_292101215081601_140141329714774016_n.jpg?_nc_cat=102&_nc_sid=85a577&_nc_eui2=AeG3sDCXjo2IhwxqDC-qgNNWhNkpuk0GQRdFsDQB2qIwEo45LQNhGDgJpu91L29oayz_HR8Ke-6T7Cu262-cMpFlAeevPc-pycT00FpT6uqLiQ&_nc_ohc=7gi4gn-wFY0AX-54q0Z&_nc_ht=scontent.fsdu15-1.fna&oh=3f2f5705ed4b0a2f5629d5d1ae1b45b3&oe=5EF077B8";

  void switUser() {
    String _backupString = _mainProfilePicture;

    setState(() {
      _mainProfilePicture = _otherProfilePicture;
      _otherProfilePicture = _backupString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Micro"),
        backgroundColor: Colors.black,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Sílvio Silva"),
              accountEmail: new Text("silviosilva.ads@gmail.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () => print("Essa é a conta principal"),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(_mainProfilePicture),
                  // image: new Image.asset("images/usuario.png"),
                ),
              ),
              otherAccountsPictures: <Widget>[
                new GestureDetector(
                  onTap: () => switUser(),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(_otherProfilePicture),
                  ),
                ),
              ],
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new NetworkImage(_url)),
              ),
            ),
            new ListTile(
              title: new Text("Leitura QrCode"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () => Navigator.of(context).pushNamed("/QrScanner"),
            ),
              
              new ListTile(
              title: new Text("Captura QrCode"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () => Navigator.of(context).pushNamed("/QrScannerLeitura"),
            ),

            new ListTile(
              title: new Text("Carteira"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Carteira())),
            ),
           
            new ListTile(
              title: new Text("Ajuda"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Ajuda())),
            ),
            new ListTile(
              title: new Text("Configurações"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Configuracoes())),
            ),
            new ListTile(
              title: new Text("Sobre a empresa"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () => Navigator.of(context).pushNamed("/EmpresaDetalhe"),
            ),
            new ListTile(
                title: new Text("Termos de uso"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () => Navigator.of(context).pushNamed("/TermosUso")),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: Container(
         height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          
    child: Row(
         children: <Widget>[
                   
           Expanded(
           child: Container(
            padding: EdgeInsets.all(50),
            color: Colors.greenAccent,
            child: Icon(Icons.credit_card),
            ),
            
          ),
          
          Expanded(
           child: Container(
            padding: EdgeInsets.all(50),
            color: Colors.greenAccent,
            child: Icon(Icons.calendar_view_day),
          ),
          ),

          Expanded(
           child: Container(
            padding: EdgeInsets.all(50),
            color: Colors.greenAccent,
            child: Padding(padding: EdgeInsets.only(top: 0),
            child: Icon(
              Icons.attach_money),
            
            
            
          ),
          ),
        ),
       
        
        ],
      )
      )

    );
  }
}
