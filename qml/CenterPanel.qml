import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import App 1.0
import ColorToolProcessor 1.0
import ImageStorage 1.0

Rectangle {
    id: center
    color: Material.backgroundColor
    Material.theme: Material.Dark

    property ImageManager imageManager: null
    property ColorToolProcessor colorProcessor: null
    property string previewImagePath: ""
    property ImageStorage imageStorage: null


    Connections {
        target: colorProcessor
        function onPreviewReady(imagePath) {
            previewImagePath = imagePath
            console.log("Preview ready:", imagePath)
        }
    }

    Column {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            width: parent.width
            height: parent.height - 80
            color: Material.backgroundColor
            border.color: Material.frameColor
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: imageManager && imageManager.imageUrls.length > 0 ? "" : "No image loaded\nSelect images to get started"
                color: Material.foreground
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                visible: !imageManager || imageManager.imageUrls.length === 0
            }


            Image {
                id: currentImage
                anchors.centerIn: parent
                source: imageManager && imageManager.imageUrls.length > 0 ? imageManager.imageUrls[imageManager.currentIndex] : ""
                fillMode: Image.PreserveAspectFit
                width: Math.min(parent.width - 20, 600)
                height: Math.min(parent.height - 20, 600)
                visible: imageManager && imageManager.imageUrls.length > 0 && previewImagePath === ""
            }


            Image {
                id: previewImage
                anchors.centerIn: parent
                source: previewImagePath
                fillMode: Image.PreserveAspectFit
                width: Math.min(parent.width - 20, 600)
                height: Math.min(parent.height - 20, 600)
                visible: previewImagePath !== ""

                onStatusChanged: {
                    if (status === Image.Error) {
                        console.log("Error loading preview image:", source)
                    } else if (status === Image.Ready) {
                        console.log("Preview image loaded successfully")
                    }
                }
            }
        }

        Row {
            id: navigationButtons
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: previousBtn
                width: 110
                height: 48
                text: "Previous"
                enabled: imageManager && imageManager.currentIndex > 0
                onClicked: {
                    if (imageManager) {
                        imageManager.previousImage()
                        // Reset preview when changing image
                        previewImagePath = ""
                        console.log("Previous clicked, new index:", imageManager.currentIndex)
                    }
                }
            }

            Rectangle {
                width: 120
                height: 48
                color: Material.backgroundColor
                border.color: Material.frameColor
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: imageManager && imageManager.imageUrls.length > 0 ?
                          (imageManager.currentIndex + 1) + " / " + imageManager.imageUrls.length :
                          "0 / 0"
                    color: Material.foreground
                    font.pixelSize: 14
                }
            }

            Button {
                id: nextBtn
                width: 110
                height: 48
                text: "Next"
                enabled: imageManager && imageManager.currentIndex < (imageManager.imageUrls.length - 1)
                onClicked: {
                    if (imageManager) {
                        imageManager.nextImage()
                        previewImagePath = ""
                        console.log("Next clicked, new index:", imageManager.currentIndex)
                    }
                }
            }
        }
    }
}
