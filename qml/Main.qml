import QtQuick
import App 1.0
import App 2.0

Window {
    id: window
    width: 1200
    height: 800
    visible: true
    title: "Image Editor"


    ImageManager {
        id: sharedImageManager
    }

    SelectionManager{
        id: sharedSelectionManger
    }

    LeftPanel {
        id: leftPanel
        imageManager: sharedImageManager
        selectionManager: sharedSelectionManger
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.2
    }


    CenterPanel {
        id: centerPanel
        imageManager: sharedImageManager

        anchors.left: leftPanel.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.5
    }

    RightPanel{
        id:rightPanel
        selectionManager: sharedSelectionManger
        anchors.left: centerPanel.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.3
    }
}
