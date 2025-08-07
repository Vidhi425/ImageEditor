import QtQuick
import QtQuick.Controls.Material
import App 1.0
import App 2.0
import ColorToolProcessor 1.0

Rectangle{
    id: right
    color: Material.backgroundColor

    property SelectionManager selectionManager: null
    property ImageManager imageManager: null
    property ColorToolProcessor colorProcessor: null

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: {
            if (!selectionManager) {
                console.log("SelectionManager is null")
                return ""
            }
            console.log("Selected option:", selectionManager.selectedOption)
            switch (selectionManager.selectedOption) {
                case "Grayscale": return "tools/color/grayscale.qml"
                default: return ""
            }
        }

        onLoaded: {
            console.log("Loader loaded:", source)
            if (item) {
                if (item.hasOwnProperty("imageManager")) {
                    item.imageManager = right.imageManager
                }
                if (item.hasOwnProperty("colorProcessor")) {
                    item.colorProcessor = right.colorProcessor
                }
                if (item.hasOwnProperty("selectionManager")) {
                    item.selectionManager = right.selectionManager
                }
                console.log("Properties assigned to loaded item")
            }
        }

        onSourceChanged: {
            console.log("Loader source changed to:", source)
        }
    }
}
