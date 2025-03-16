import QtQuick 2.15
import QtQuick3D
import QtQuick.Window 2.15

Window {
    visible: true
    width: 800
    height: 600
    title: "CustomMaterial Example"

    // 创建3D场景
    View3D {
        anchors.fill: parent

        // 摄像机设置
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, 600)
        }

        // 环境光
        environment {
            id: environment
            backgroundMode: SceneEnvironment.Color
            clearColor: "#808080"
        }

        DirectionalLight {
            position: Qt.vector3d(0,0, 1000)
            color: Qt.rgba(0.2, 0.2, 0.2, 1.0)
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        }

        // 立方体模型
        Model {
            id: cube
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            position:Qt.vector3d(0, 0, 0)

            // 自定义材质
            materials: [
                CustomMaterial {
                    // These properties are automatically exposed to the shaders
                    property real time: 0.0
                    property real amplitude: 5.0
                    property real alpha: 1.0
                    NumberAnimation on time { from: 0; to: 100; duration: 10000; loops: -1 }

                    property TextureInput tex: TextureInput {
                        enabled: true
                        texture: Texture { source: "image.png" }
                    }

                    shadingMode: CustomMaterial.Unshaded
                    sourceBlend: alpha < 1.0 ? CustomMaterial.SrcAlpha : CustomMaterial.NoBlend
                    destinationBlend: alpha < 1.0 ? CustomMaterial.OneMinusSrcAlpha : CustomMaterial.NoBlend
                    cullMode: CustomMaterial.BackFaceCulling

                    vertexShader: "shaders/vertexshader.vert"
                    fragmentShader: "shaders/fragmentshader.frag"
                }
            ]
        }
    }
}