import QtQuick
import QtQuick.Controls.Material
import App 2.0

Rectangle{
    id:right
    color:Material.backgroundColor
    property SelectionManager selectionManager: null

    Loader {
            id: viewLoader
            anchors.fill: parent

            source: {
                switch (selectionManager.selectedOption) {
                    case "Grayscale": return "tools/color/grayscale.qml";

                    default: return "";
                }
            }
    }

}
