import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.folderlistmodel 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property string prefix: "file:/var/log"
    property int lineHeight: 20

    ListView {
        id:listView
        anchors.fill: parent
        model: folderModel
        focus: true
        highlight: highlightBar
        highlightFollowsCurrentItem: false
        delegate:_delegate
    }

    FolderListModel {
        id:folderModel
        folder: prefix
    }

    Component {
        id: _delegate
        Rectangle {
            id:itemRect
            color: "transparent"
            width: _text.width
            height: lineHeight
            Text {
                id:_text
                       text:qsTr(fileName)
                   }
            MouseArea {
                   anchors.fill: parent
                   onClicked: {
                       listView.currentIndex = index
                       console.log("clicked: "+listView.currentIndex)
                   }
                   onDoubleClicked: {
                       console.log("double clicked: "+listView.currentIndex)
                   }
             }
        }
    }

    Component {
        id: highlightBar
        Rectangle {
            opacity: 0.2
            width:200; height: lineHeight
            color: "blue"
            y:listView.currentItem.y;
            Behavior on y {SpringAnimation {spring: 0.5; damping: 0.1}}
        }
    }
}
