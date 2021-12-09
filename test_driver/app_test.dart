import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main()
{
  group('test', () {
    late FlutterDriver driver;

setUpAll(() async{
driver = await FlutterDriver.connect();
});

tearDownAll(()async{
  await driver.close();
});
 
group('Happy Paths', (){
/*
Given I am on the sign page
when I input a "josefvassell@gmail.com"
when I input the correct password
then I should move to the all products page
*/
test(
  'Let you click on the login button after you type in an email, and password that is already in the database, then it should take you to the scroll page   ',
  ()async{

    final loginbuttonFinder= find.byValueKey('login-btn');
    final emailinputs = find.byValueKey('email-input');
    final passwordinputs= find.byValueKey('pwd-input');
   final  BottomNavigationBarItem= find.byValueKey('bottom');
   final logoutbuttonFinder= find.byValueKey('logout-btn');
   final logout2buttonFinder= find.byValueKey('logout-ok-btn');

   await driver.tap(emailinputs);
   await driver.enterText('josefvassell@gmail.com');
   await driver.tap(passwordinputs);
   await driver.enterText('Hardwork12!');
   await driver.tap(loginbuttonFinder);
   await driver.waitFor(find.text("Rent"));
   await driver.waitFor(find.byValueKey('bottom'));
   await driver.tap(find.text('Settings'));
   await driver.tap(logoutbuttonFinder);
   await driver.tap(logout2buttonFinder);


   
});

test('Let you click on the Sign up text, then take you to create account page, then use that information to login into the app ',()async{
final signuptext = find.byValueKey('signup-txt');
final emailinputs = find.byValueKey('email-input');
final passwordinputs= find.byValueKey('pwd-input');
final createbuttonFinder = find.byValueKey('create-btn');
final signintextbutton = find.byValueKey('signin-txt');
final loginbuttonFinder= find.byValueKey('login-btn');
final logoutbuttonFinder= find.byValueKey('logout-btn');
final logout2buttonFinder= find.byValueKey('logout-ok-btn');


await driver.tap(signuptext);
await driver.tap(emailinputs);
await driver.enterText('test1@gmail.com');
await driver.tap(passwordinputs);
await driver.enterText('123qwe');
await driver.tap(createbuttonFinder);
//await driver.waitFor(find.text('Sign In'));
await driver.tap(signintextbutton);


await driver.tap(emailinputs);
await driver.enterText('test1@gmail.com');
await driver.tap(passwordinputs);
await driver.enterText('123qwe');
await driver.tap(loginbuttonFinder);

await driver.waitFor(find.byValueKey('bottom'));
await driver.tap(find.text('Settings'));
await driver.tap(logoutbuttonFinder);
await driver.tap(logout2buttonFinder);
});

test(
  "After logining then you should be able to click on the Laptop picture then it will take you to the scoll product page",() 
  async {
    final loginbuttonFinder= find.byValueKey('login-btn');
    final emailinputs = find.byValueKey('email-input');
    final passwordinputs= find.byValueKey('pwd-input');
    final laptopicbutton = find.byValueKey('laptop-pic');

   await driver.tap(emailinputs);
   await driver.enterText('josefvassell@gmail.com');
   await driver.tap(passwordinputs);
   await driver.enterText('Hardwork12!');
   await driver.tap(loginbuttonFinder);
   await driver.waitFor(find.text("Rent"));
   await driver.tap(laptopicbutton);
});

});

group('bottombar naviagtion', () {
  test('If I click the bottombar naviagtion that they all should work',() async
  {
     final  BottomNavigationBarItem= find.byValueKey('bottom');
     
     await driver.tap(find.text('Home'));
     await driver.tap(find.text('All Products'));
     await driver.tap(find.text('Add Product'));
     await driver.tap(find.text('Rented Products'));
     await driver.tap(find.text('Settings'));
  });
  test('if I am on the settting page and click the edit button', ()async 
{ 
 //final signintextbutton = find.byValueKey('signin-txt');
final editemailbutton = find.byValueKey('edit-email-btn');
final editnoemailbutton = find.byValueKey('email-no-btn');

 await driver.tap(editemailbutton);
 await driver.waitFor(find.text('If you want to update your email, enter your password hit the submit button. '));
 await driver.tap(editnoemailbutton);
});
test('if I am on the setting page and click the password', ()async
{
final editpwdbutton = find.byValueKey('edit-pwd-btn');
final editnopwdbutton = find.byValueKey('pwd-no-btn');
final logoutbuttonFinder= find.byValueKey('logout-btn');
final logout2buttonFinder= find.byValueKey('logout-ok-btn');


await driver.tap(editpwdbutton);
await driver.waitFor(find.text('If you want to update your password, enter your previous password hit the submit button. '));
await driver.tap(editnopwdbutton);
await driver.tap(logoutbuttonFinder);
await driver.tap(logout2buttonFinder);
});

});

group('sad path', () {
  test('If I am on the login page, and type my mu username, but not my passwod I should stay on the login page until I type both username and password ',() async
  {
  final loginbuttonFinder= find.byValueKey('login-btn');
  final emailinputs = find.byValueKey('email-input');
  final passwordinputs= find.byValueKey('pwd-input');
  final  BottomNavigationBarItem= find.byValueKey('bottom');
  final logoutbuttonFinder= find.byValueKey('logout-btn');
  final logout2buttonFinder= find.byValueKey('logout-ok-btn');

  await driver.tap(emailinputs);
  await driver.enterText('josefvassell@gmail.com');
  await driver.tap(loginbuttonFinder);
  await driver.waitFor(find.text("Sign In"));
   await driver.tap(passwordinputs);
   await driver.enterText('Hardwork12!');
   await driver.tap(loginbuttonFinder);
   
   await driver.waitFor(find.byValueKey('bottom'));
   await driver.tap(find.text('Settings'));
   await driver.tap(logoutbuttonFinder);
   await driver.tap(logout2buttonFinder);

  });
  test('If I am on the login page, and type my mu password, but not my username I should stay on the login page until I type both username and password ', ()async 
{ 
 final loginbuttonFinder= find.byValueKey('login-btn');
  final emailinputs = find.byValueKey('email-input');
  final passwordinputs= find.byValueKey('pwd-input');
  final  BottomNavigationBarItem= find.byValueKey('bottom');
  final logoutbuttonFinder= find.byValueKey('logout-btn');
  final logout2buttonFinder= find.byValueKey('logout-ok-btn');

   await driver.tap(passwordinputs);
   await driver.enterText('Hardwork12!');
   await driver.waitFor(find.text("Sign In"));
   await driver.tap(loginbuttonFinder);
   await driver.tap(emailinputs);
   await driver.enterText('josefvassell@gmail.com');
   await driver.tap(loginbuttonFinder);
   await driver.waitFor(find.byValueKey('bottom'));
   await driver.tap(find.text('Settings'));
   await driver.tap(logoutbuttonFinder);
   await driver.tap(logout2buttonFinder);
});


});
 test('After I login in I should go to my cart, and see the products in my cart', ()async 
 {
 final loginbuttonFinder= find.byValueKey('login-btn');
 final emailinputs = find.byValueKey('email-input');
 final passwordinputs= find.byValueKey('pwd-input');
final  BottomNavigationBarItem= find.byValueKey('bottom');
 final cartbutton =find.byValueKey('cart-btn');
   await driver.tap(emailinputs);
   await driver.enterText('josefvassell@gmail.com');
   await driver.tap(passwordinputs);
   await driver.enterText('Hardwork12!');
   await driver.tap(loginbuttonFinder);
   await driver.waitFor(find.text("Rent"));
   await driver.tap(cartbutton);

 });
  });
}