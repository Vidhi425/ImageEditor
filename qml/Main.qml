import QtQuick
import QtQuick.Controls.Material
import App 1.0
import App 2.0
import ColorToolProcessor 1.0
import ImageStorage 1.0

Window {
    id: window
    width: 1200
    height: 800
    visible: true
    title: "Image Editor"
    Material.theme: Material.Dark

    ImageManager {
        id: sharedImageManager
        onCurrentImageIndexChanged: function(index) {
                       sharedColorToolProcessor.setCurrentImageIndex(index)
                   }
    }

    SelectionManager{
        id: sharedSelectionManger
    }

    ColorToolProcessor{
        id:sharedColorToolProcessor
    }

    ImageStorage{
        id:sharedImageStorage
    }

    Component.onCompleted: {

        sharedImageManager.setImageStorage(sharedImageStorage)
        sharedColorToolProcessor.setCurrentImageIndex(0)

        sharedColorToolProcessor.setImageStorage(sharedImageStorage)

        console.log("All components connected successfully")
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
        colorProcessor:sharedColorToolProcessor
        imageStorage: sharedImageStorage
        anchors.left: leftPanel.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.5
    }

    RightPanel{
        id:rightPanel
        selectionManager: sharedSelectionManger
        colorProcessor:sharedColorToolProcessor
        imageManager: sharedImageManager
        anchors.left: centerPanel.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width * 0.3
    }
}
