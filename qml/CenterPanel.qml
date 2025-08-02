import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import App 1.0

Rectangle {
    id: center
    color: "#ffffff"
    anchors.margins: 10

    property ImageManager imageManager: null

    Column {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            width: parent.width
            height: parent.height - 80
            color: "#f5f5f5"
            border.color: "#e0e0e0"
            border.width: 1


            Text {
                anchors.centerIn: parent
                text: imageManager && imageManager.imageUrls.length > 0 ? "" : "No image loaded\nSelect images to get started"
                color: "#666666"
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
                visible: imageManager && imageManager.imageUrls.length > 0





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
                        console.log("Previous clicked, new index:", imageManager.currentIndex)
                    }
                }
            }


            Rectangle {
                width: 120
                height: 48
                color: "#f5f5f5"
                border.color: "#ddd"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: imageManager && imageManager.imageUrls.length > 0 ?
                          (imageManager.currentIndex + 1) + " / " + imageManager.imageUrls.length :
                          "0 / 0"
                    color: "#333"
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
                        console.log("Next clicked, new index:", imageManager.currentIndex)
                    }
                }
            }
        }
    }
}
