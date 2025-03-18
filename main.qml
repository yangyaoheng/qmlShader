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
        /*Model {
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

        Model {
            id: model
            source: "#Cube"
            scale: Qt.vector3d(0.5, 0.5, 0.5)
            position: Qt.vector3d(0, 0, 0)
            eulerRotation: Qt.vector3d(0, 0, 0)
            materials: [
                DefaultMaterial {
                    diffuseColor: Qt.rgba(0, 1, 0, 1)
                }
            ]

            Timer {
                id: animTimer
                interval: 16
                running: true
                repeat: true
                property real t: 0
                onTriggered: {
                    t += 0.01
                    // 计算复杂三维路径上的位置，这里以螺旋线为例
                    model.position = Qt.vector3d(
                        2 * Math.cos(t * 10),
                        2 * Math.sin(t * 10),
                        t
                    )
                    // 计算旋转角度，这里绕 Y 轴旋转
                    model.eulerRotation = Qt.vector3d(0, t * 100, 0)
                }
            }
        }*/

        Model {
            id: model
            source: "#Sphere"
            scale: Qt.vector3d(0.5, 0.5, 0.5)
            position: Qt.vector3d(0, 0, 0)
            materials: [
                DefaultMaterial {
                    diffuseColor: Qt.rgba(0, 1, 0, 1)
                }
            ]
            
            // 定义 Bezier 曲线的控制点
            property var controlPoints: [
                Qt.vector3d(0, 0, 0),
                Qt.vector3d(1, 2, 1),
                Qt.vector3d(3, -1, 2),
                Qt.vector3d(4, 0, 0)
            ]

            Timer {
                id: animTimer
                interval: 30
                running: true
                repeat: true
                property real t: 0
                property int steps: 100

                onTriggered: {
                    if (t >= 1) {
                        t = 0
                    }
                    // 计算 Bezier 曲线上的点
                    var point = model.calculateBezierPoint(t,model.controlPoints)
                    model.position = point
                    t += interval
                }
            }

            function calculateBezierPoint(t, points) {
                var n = points.length - 1
                var result = Qt.vector3d(0, 0, 0)
                for (var i = 0; i <= n; i++) {
                    var coefficient = binomialCoefficient(n, i) * Math.pow(1 - t, n - i) * Math.pow(t, i)
                    result = result.plus(points[i].times(coefficient))
                }
                return result
            }

            function binomialCoefficient(n, k) {
                var result = 1
                for (var i = 1; i <= k; i++) {
                    result *= (n - (k - i)) / i
                }
                return result
            }
        }
    }
}