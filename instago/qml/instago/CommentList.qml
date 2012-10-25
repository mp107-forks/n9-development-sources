// *************************************************** //
// Comment List Component
//
// The comment list component is used by the application
// pages. It displays the comments for a given media id
// with their respective metadata
// The list is flickable and clips.
// *************************************************** //

import QtQuick 1.1

import "js/globals.js" as Globals

Rectangle {
    id: commentList

    // signal to clear the list contents
    signal clearList()
    onClearList: {
        commentListModel.clear();
    }

    // signal to jump to the bottom of the list
    signal jumpToBottom()
    onJumpToBottom: {
        commentListView.positionViewAtEnd();
    }

    // signal to add a new item
    // item is given as array:
    // "username":USER_USERNAME
    // "fullname":USER_FULLNAME
    // "profilepicture":USER_PROFILEPICTURE
    // "userid":USER_USERID
    // "index":ITEM_INDEX
    signal addToList( variant items )
    onAddToList: {
        commentListModel.append(items);
    }

    // general list properties
    property alias numberOfItems: commentListModel.count;

    // general style definition
    color: "transparent"


    // this is the main container component
    // it contains the actual user items
    Component {
        id: commentListDelegate

        // this is an individual list item
        Item {
            id: commentItem
            width: commentList.width
            // height: 110


            // this is the rectangle that holds the profile picture image
            // its used as an empty default rect that is filled if the image could be loaded
            Rectangle {
                id: commentListProfilepicture

                anchors {
                    top: parent.top
                    topMargin: 10
                    left: parent.left
                    leftMargin: 10
                }

                width: 80
                height: 80

                // light gray color to mark loading image
                color: "gainsboro"

                // the actual profile image
                Image {
                    anchors.fill: parent
                    source: d_profilepicture
                }

                // use the whole item as tap surface
                // all taps on the item will be handled by the itemClicked event
                MouseArea {
                    anchors.fill: parent
                    onClicked:
                    {
                        // console.log("Profile tapped. Id was: " + d_userid);
                        pageStack.push(Qt.resolvedUrl("UserDetailPage.qml"), {userId: d_userid});
                    }
                }
            }


            // the Instagram username of the user
            Text {
                id: commentListUsername

                anchors {
                    top: parent.top;
                    topMargin: 10;
                    left: commentListProfilepicture.right;
                    leftMargin: 5;
                    right: parent.right;
                    rightMargin: 5;
                }

                height: 35

                font.family: "Nokia Pure Text Light"
                font.pixelSize: 25
                wrapMode: Text.Wrap
                color: Globals.instagoDefaultTextColor

                text: d_username

                // use the whole item as tap surface
                // all taps on the item will be handled by the itemClicked event
                MouseArea {
                    anchors.fill: parent
                    onClicked:
                    {
                        // console.log("Profile tapped. Id was: " + d_userid);
                        pageStack.push(Qt.resolvedUrl("UserDetailPage.qml"), {userId: d_userid});
                    }
                }
            }


            // the actual comment content
            Text {
                id: commentListComment

                anchors {
                    top: commentListUsername.bottom
                    topMargin: 5;
                    left: commentListProfilepicture.right;
                    leftMargin: 10;
                    right: parent.right;
                    rightMargin: 5;
                }

                font.family: "Nokia Pure Text"
                font.pixelSize: 20
                wrapMode: Text.Wrap
                color: Globals.instagoDefaultTextColor

                onTextChanged: {
                    // this is magic: since commentListComment.height gives me garbage I calculate the height by multiplying the number of lines with the line height
                    var calculatedLines = Math.floor( (commentListComment.text.length / 44) + 1 );
                    var itemheight = Math.floor( (calculatedLines+1) * 25);
                    height = itemheight;
                    commentItem.height = itemheight + 70;
                }

                text: d_comment
            }


            // separator
            Rectangle {
                id: imagedetailSeparator

                anchors {
                    top: commentListComment.bottom
                    topMargin: 15
                    left: parent.left;
                    leftMargin: 5;
                    right: parent.right;
                    rightMargin: 5;
                }

                height: 1
                color: "gainsboro"
            }
        }
    }


    // this is just an id
    // the model is defined in the array
    ListModel {
        id: commentListModel
    }


    // the actual list view component
    // this will be the main component and contain all the items
    ListView {
        id: commentListView

        anchors.fill: parent;
        focus: true

        // clipping needs to be true so that the size is limited to the container
        clip: true

        // define model and delegate
        model: commentListModel
        delegate: commentListDelegate
    }
}
