import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About NMA"),
      ),
      body: Container(child: AboutPageBody()),
    );
  }
}

class AboutPageBody extends StatelessWidget {
  static const NMA_WEBSITE_URL = "https://www.nmakademija.lt/eng/";
  static const NMA_FACEBOOK_URL = "https://www.facebook.com/nmakademija/";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Image.asset("assets/nma-logo.png"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  child: Text(
                      "Nacionalinė moksleivių akademija (NMA) – unikali papildomo ugdymo institucija, skirta mokslui ir muzikai gabiems Lietuvos vaikams. "
                      "Nuo 2004 m. NMA ugdymo programas yra baigę daugiau nei 1300 talentingiausių vaikų iš įvairių Lietuvos kampelių. "
                      "Akademijoje stiprinamas Lietuvos intelektinis potencialas, investuojama į gabius ir motyvuotus vaikus. "),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "šiuo metu veikia 8 sekcijos",
                        style: new TextStyle(fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text("matematika"),
                    ),
                    Center(
                      child: Text("informatika"),
                    ),
                    Center(
                      child: Text("biologija ir biochemija"),
                    ),
                    Center(
                      child: Text("chemija"),
                    ),
                    Center(
                      child: Text("fizika"),
                    ),
                    Center(
                      child: Text("ekonomika"),
                    ),
                    Center(
                      child: Text("lietuvių filologija"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          child: Text("puslapis"),
          onPressed: _launchWebsite,
        ),
        RaisedButton(
          child: Text("facebook"),
          onPressed: _launchFacebook,
        ),
      ],
    );
  }

  Future<bool> _launchWebsite() async {
    return await _launchURL(NMA_WEBSITE_URL);
  }

  Future<bool> _launchFacebook() async {
    return await _launchURL(NMA_FACEBOOK_URL);
  }

  // https://pub.dev/packages/url_launcher
  Future<bool> _launchURL(String url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
