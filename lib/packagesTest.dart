import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLuncher extends StatelessWidget {
  sharePhoto() async {
    final picker = ImagePicker();
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera);
    Share.shareFiles(['${pickedFile.path}'],
        text: 'Nice Photo', subject: 'test image Picker');
  }

  sharePost(String post) {
    Share.share(post);
  }

  makeCall(int phoneNumer) async {
    if (await canLaunch('tel:$phoneNumer')) {
      await launch('tel:$phoneNumer');
    } else {
      print('Could not launch');
    }
  }

  sendSms(int number, String content) async {
    Uri uri = Uri(
      scheme: 'sms',
      path: '$number',
      query: 'subject=$number&body=$content',
    );
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      print('Could not launch ${uri.toString()}');
    }
  }

  sendEmail(String email, String otherEmail, String title, String body) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto', path: otherEmail, query: 'subject=$title&body=$body');
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      print('Could not launch ${_emailLaunchUri.toString()}');
    }
  }

  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('urlLuncher'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                  child: Text('OpenUrl'),
                  onPressed: () {
                    openUrl('https://pub.dev/packages/url_launcher');
                  }),
              RaisedButton(
                  child: Text('Call Me'),
                  onPressed: () {
                    makeCall(0590000000000);
                  }),
              RaisedButton(
                  child: Text('Send sms'),
                  onPressed: () {
                    sendSms(0590000000000, 'my sms');
                  }),
              RaisedButton(
                  child: Text('Send Email'),
                  onPressed: () {
                    sendEmail('mam.farra2030@gmail.com', 'test@gmail.com',
                        'textEmail', 'test email for you');
                  }),
              RaisedButton(
                  child: Text('Share Post'),
                  onPressed: () {
                    sharePost('this is my shared post');
                  }),
              RaisedButton(
                  child: Text('Share Photo'),
                  onPressed: () {
                    sharePhoto();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
