import QtQuick
import QtQuick.Controls.Material


Rectangle{
    id:grayscale
    Material.background: Material.Teal
    Text {
        anchors.centerIn: parent
        text: "Grayscale loading soon"
        color: "#666666"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter

    }
}
