# WeatherApp using Flutter
This is a personal project I have created which is a Weather app using Dart &amp; Flutter and the OpenWeatherMap API. It technically has only 2 screens and 1 modal sheet. 

The first is a Loading Screen with a Spinner and the other one is the main screen which displays the weather and more information: a 7 days forecast, the date, the location, max and min temperatures and an icon representing the weather condition. 
In this screen you also have 2 buttons: one to display the current location weather if for example you are moving or you previously checked a different location and the other button for searching a new location. The latter will open a kind of fixed popup where you can type any location you want and my app will display you the weather forecast for it :) 

Whether you search for a new location or you press the button for the current weather a spinner will become visible in the screen you are currently at.

You can clone it if you want! If you are going to do something else with it at least message me please ;)

# How to clone this app

To get the weather information I used the OpenWeatherMap OneCall API which is free for a limited number of requests per minute. I didn't include the API Key in the project for obvious reasons, thus you will need to do a quick registration to get your API Key. Don't worry! It will just take you 2 minutes!



* Get yourself inside a folder an initialize the folder as a git repo:
`git init`

* Now clone the app with:
`git clone https://github.com/Rffrench/WeatherApp-Flutter.git`

* Head to: https://openweathermap.org/ and click in the menu item "API" then where it says "One Call API" click on "Subscribe". Now you should be in the Plan selection page so head to "Free" and click on "Get API Key", complete the registration, confirm you email and Sign In. Once you are logged in click on "API Keys" and copy the key. If you don't see any key just repeat the first steps. 
###### NOTE: It's important that you get the One Call API key, if you get one of a different category the app won't work!

* Open the folder it has just been created called WeatherApp-FLutter with your favorite IDE (preferably VS Code) and inside this folder create a file called '.env' (don't include the ' '). Make sure the file is inside the folder!

* Inside this file type the following:
`APIKEY=ABC123`
###### Where ABC123 is your API Key of the OpenWeatherMap OneCall API

* Save everything and inside the main.dart file hit "Run" or press F5 to run the project. If you have your phone connected and with debug mode allowed the app should get installed in your phone. If not, you can use an emulator to run apps. If you didn't understand what I have just said then head to this link: https://stackoverflow.com/questions/54444538/how-do-i-run-test-my-flutter-app-on-a-real-device for running the app on your phone or this link https://flutterappdev.com/2018/12/12/how-to-setup-flutter-on-android-studio-for-beginners-in-macos/ for running the app on an emulator

### If everything went well you should now have the app running!


# Screenshots

<div><h6>GIF Demo</h6>
<img src="https://github.com/Rffrench/WeatherApp-Flutter/blob/master/images/app-demo/weather-app-flutter.gif" width="20%"></div>
<div><h6>Loading Screen</h6>
<img src="https://github.com/Rffrench/WeatherApp-Flutter/blob/master/images/app-demo/loading-screen.png" width="20%"></div>
<div><h6>Main Screen</h6>
<img src="https://github.com/Rffrench/WeatherApp-Flutter/blob/master/images/app-demo/main-screen.png" width="20%"></div>
<div><h6>Change Location</h6>
<img src="https://github.com/Rffrench/WeatherApp-Flutter/blob/master/images/app-demo/change-location.png" width="20%"></div>

