import QtQuick
import QtQuick.Controls.Material
import App 1.0

Rectangle {
    id: grayscale
    color: "#2C2C2C"

    property var colorProcessor: null
    property ImageManager imageManager: null

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 25

        // Header
        Text {
            text: "Grayscale Settings"
            color: "#FFFFFF"
            font.pixelSize: 18
            font.bold: true
        }

        // Intensity Control
        Column {
            width: parent.width
            spacing: 10

            Text {
                text: "Intensity"
                color: "#CCCCCC"
                font.pixelSize: 14
            }

            Slider {
                id: intensitySlider
                width: parent.width
                from: 0
                to: 100
                value: 50
                Material.accent: Material.Teal

                onValueChanged:{
                    if(colorProcessor && imageManager){
                        colorProcessor.applyGrayscale(value, contrastSlider.value);
                    }
                }

                background: Rectangle {
                    x: intensitySlider.leftPadding
                    y: intensitySlider.topPadding + intensitySlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 6
                    width: intensitySlider.availableWidth
                    height: implicitHeight
                    radius: 3
                    color: "#404040"

                    Rectangle {
                        width: intensitySlider.visualPosition * parent.width
                        height: parent.height
                        color: Material.Teal
                        radius: 3
                    }
                }
            }

            Text {
                text: Math.round(intensitySlider.value) + "%"
                color: "#AAAAAA"
                font.pixelSize: 12
            }
        }

        // Contrast Control
        Column {
            width: parent.width
            spacing: 10

            Text {
                text: "Contrast"
                color: "#CCCCCC"
                font.pixelSize: 14
            }

            Slider {
                id: contrastSlider
                width: parent.width
                from: -50
                to: 50
                value: 0
                Material.accent: Material.Teal

                onValueChanged: {
                    if (colorProcessor && imageManager) {
                        colorProcessor.applyGrayscale(intensitySlider.value, value)
                    }
                }

                background: Rectangle {
                    x: contrastSlider.leftPadding
                    y: contrastSlider.topPadding + contrastSlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 6
                    width: contrastSlider.availableWidth
                    height: implicitHeight
                    radius: 3
                    color: "#404040"

                    Rectangle {
                        width: contrastSlider.visualPosition * parent.width
                        height: parent.height
                        color: Material.Teal
                        radius: 3
                    }
                }
            }

            Text {
                text: Math.round(contrastSlider.value)
                color: "#AAAAAA"
                font.pixelSize: 12
            }
        }

        // Action Buttons
        Row {
            width: parent.width
            spacing: 10

            Button {
                text: "Reset"
                Material.background: "#404040"
                Material.foreground: "#FFFFFF"
                onClicked: {
                    intensitySlider.value = 50
                    contrastSlider.value = 0
                }
            }

            Button {
                text: "Apply"
                Material.background: Material.Teal
                Material.foreground: "#FFFFFF"
                onClicked: {
                    console.log("Applying grayscale - Intensity:", intensitySlider.value, "Contrast:", contrastSlider.value)
                }
            }
        }
    }
}
