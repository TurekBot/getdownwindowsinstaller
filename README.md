# Getdown - Windows Installer #

Shows how to package your application in an installer along side getdown. Getdown will update the app each time the app is opened.

### To get started ###
1. You need to install NSIS for generating the native installer.
    1. http://nsis.sourceforge.net/Download
1. Fill in, change, or comment out anything in `pom.xml` that is labeled with `FILLMEIN`.
1. Provide your own images
    1. You can replace `myapp.ico` with your own icon
        1. You'll need to either rename *your* icon or *rename all of the "myapp.ico"* in `installationConfiguration.nsi`
    1. You can replace `myappsmall.ico` with your own icon
        1. You'll need to either rename *your* icon or *rename all of the "myappsmall.ico"* in `installationConfiguration.nsi`
    1. You can replace `myappbanner.bmp` with your own banner
        1. You'll need to either rename *your* banner or *rename all of the "myappbanner.bmp"* in `installationConfiguration.nsi`
1. [Choose a license](www.choosealicense.com) and put it in `nsis/License.txt`
1. Add some instructions for the user to `nsis/Readme.txt`
1. Run `mvn package`
1. This will generate 3 folders in the `target` directory: `getdown`, `getdown-stub`, and `getdown-applet`
    1. The `getdown` folder contains everything that getdown needs in order to perform an update.
    1. The `getdown-stub` folder contains everything that the installer needs.
    1. The `getdown-applet` folder contains everything you need to deploy the application as an applet.
1. Copy the contents of `target/getdown` to your website/local webserver
    1. (make sure it's located specifically at whatever you put in `appbase`).
1. Run the installer; this will
    1. download the application from your website/local webserver
    1. and install the application on your computer.
     

### To test the updating ###
1. Change something in your app
1. Run `mvn package`
1. Upload the contents of the `getdown` folder to your website/local webserver.
    1. Make sure it's placed exactly at `appbase`
1. Open up the application from the start menu
1. Watch your program update itself.

### [Getdown](https://github.com/threerings/getdown/wiki) ###
* To learn how Getdown works see the [Getdown documentation](https://github.com/threerings/getdown/wiki)