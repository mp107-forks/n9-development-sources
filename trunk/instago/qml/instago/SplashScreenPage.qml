// *************************************************** //
// Splash Screen Page
//
// This page shows the splash screen while preloading
// some data from Instagram in the background.
// *************************************************** //

import QtQuick 1.1
import com.nokia.meego 1.0

import "js/globals.js" as Globals

Page {
    // lock orientation to portrait mode
    orientationLock: PageOrientation.LockPortrait


    // this is the splash image, shown in fullscreen
    Image {
        id: splashImage
        source: "img/instago_splashscreen.png"
        anchors.fill: parent
    }


    // version information, pulled from the globals.js
    Text {
        id : splashVersionInformation

        y: 560
        width: 480

        font.family: "Nokia Pure Text"
        font.pixelSize: 20

        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        textFormat: Text.RichText

        color: "white"
        text: Globals.currentApplicationVersion;
    }


    // wait for 2 seconds while the PopularPhotosPage is loading data
    // this is triggerd by the PageStackWindow which already registered
    // the page, thus activating it in the background
    Timer {
        id: splashTimer
        interval: 2000
        running: true
        repeat:  false

        // when done, replace the splash page with the popular photos page
        onTriggered: {
            console.log("Closing splash screen");
            pageStack.replace(popularPhotosPage);
        }
    }
}