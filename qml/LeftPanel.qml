import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtQuick.Layouts 1.15
import App 1.0
import App 2.0

Rectangle {
    id: leftPanel
    color: Material.backgroundColor

    property bool filesLoaded: false
    property int selectedFilesCount: 0
    property string currentTool: ""
    property ImageManager imageManager: null
    property SelectionManager selectionManager: null

    ScrollView {
        anchors.fill: parent
        anchors.margins: 10
        clip: true
        ScrollBar.vertical: null
        ScrollBar.horizontal: null

        ColumnLayout {
            width: leftPanel.width - 20
            spacing: 15

            FileDialog {
                id: fileDialog
                title: "Select Images"
                fileMode: FileDialog.OpenFiles
                nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp *.gif *.tiff)"]

                onAccepted: {
                    console.log("Selected files:", selectedFiles)
                    leftPanel.selectedFilesCount = selectedFiles.length
                    leftPanel.filesLoaded = true
                    console.log("Selected " + selectedFilesCount + " files")

                    if (imageManager) {
                        imageManager.processImagePaths(selectedFiles)
                    } else {
                        console.log("ImageManager is null!")
                    }
                }

                onRejected: {
                    console.log("File selection cancelled")
                }
            }

            GroupBox {
                Layout.fillWidth: true
                title: "File Operations"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 8

                    Button {
                        Layout.fillWidth: true
                        text: filesLoaded ? `📁 ${selectedFilesCount} Images Loaded` : "📁 Upload Images"
                        onClicked: fileDialog.open()
                    }

                    Button {
                        Layout.fillWidth: true
                        text: "💾 Export All"
                        enabled: filesLoaded
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                title: "🎨 Color Tools"

                ComboBox {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    enabled: filesLoaded
                    model: ["Choose Tool", "Grayscale", "Color Inversion", "Brightness/Contrast", "Hue/Saturation"]
                    onCurrentTextChanged: {
                        if (currentIndex === 0) {
                            currentTool = ""
                        } else {
                            currentTool = currentText
                        }
                        console.log("Selected tool:", currentTool)
                        selectionManager.selectedOption = currentText
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                title: "🔄 Transform Tools"

                ComboBox {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    enabled: filesLoaded
                    model: ["Choose Tool", "Rotation", "Resize/Scale", "Crop"]
                    onCurrentTextChanged: {
                        if (currentIndex === 0) {
                            currentTool = ""
                        } else {
                            currentTool = currentText
                        }
                        console.log("Selected tool:", currentTool)
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                title: "🔍 Filter Tools"

                ComboBox {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    enabled: filesLoaded
                    model: ["Choose Tool", "Blur", "Sharpen", "Edge Detection"]
                    onCurrentTextChanged: {
                        if (currentIndex === 0) {
                            currentTool = ""
                        } else {
                            currentTool = currentText
                        }
                        console.log("Selected tool:", currentTool)
                    }
                }
            }

            GroupBox {
                Layout.fillWidth: true
                title: "Quick Actions"

                RowLayout {
                    anchors.fill: parent
                    spacing: 8

                    Button {
                        Layout.fillWidth: true
                        text: "↶ Undo"
                        enabled: false
                    }

                    Button {
                        Layout.fillWidth: true
                        text: "↷ Redo"
                        enabled: false
                    }
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.minimumHeight: 10
            }
        }
    }
}
