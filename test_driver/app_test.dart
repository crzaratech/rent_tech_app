import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main()
{
  group('test', () {
    late FlutterDriver driver;

setUpAll(() async{
driver = await FlutterDriver.connect();
});

/*tearDownAll(()async{
  await driver.close();
});*/
 
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
/*
test('test product',()async
{
final productbutton = find.byValueKey('product-btn');
await driver.tap(productbutton);

await driver.waitFor(find.text("Add To Cart"));



});
*/
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
});

/*
 group('sad path',(){
test('',()async{

});

 });*/
  });
}