# Getdown - Windows Installer #

Shows how to package your application in an installer along side getdown. Getdown will update the app each time the app is opened.

### To get started ###
1. You need to install NSIS for generating the native installer.
    1. http://nsis.sourceforge.net/Download
1. Fill in, change, or comment out anything in `pom.xml` that is labeled with `FILLMEIN`.
1. Replace all instances of the string "MyApp" in `nsis\myapp.nsi` with the name of your app.
1. Run `mvn package`
1. This will generate 3 folders: *getdown*, *getdown-stub*, and *getdown-applet*
    1. The *getdown* folder contains everything that getdown needs in order to perform an update.
    1. The *getdown-stub* folder contains everything that the installer needs.
    1. The *getdown-applet* folder contains everything you need to deploy the application as an applet.
1. Copy the contents of *target/getdown* to your website/local webserver
    1. (make sure it's located specifically at whatever you put in `appbase`).
1. Run the installer; this will
    1. download the application from your website/local webserver
    1. and install the application on your computer.
     

### To test the updating ###
1. Change something in your app
1. Run `mvn package`
1. Upload the contents of the *getdown* folder to your website/local webserver.
    1. Make sure it's placed exactly at `appbase`
1. Open up the application from the start menu
1. Watch your program update itself.

### [Getdown](https://github.com/threerings/getdown/wiki) ###
* To learn how Getdown works see the [Getdown documentation](https://github.com/threerings/getdown/wiki)