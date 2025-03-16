import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 400
    height: 400
    visible: true

    ShaderEffect {
        anchors.fill: parent
        property variant source
        vertexShader: "qrc:/shaders/vertexshader.vert"
        fragmentShader: "qrc:/shaders/fragmentshader.frag"

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF0000" }
                GradientStop { position: 1.0; color: "#0000FF" }
            }
        }
    }
}