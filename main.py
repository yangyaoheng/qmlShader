import sys
from PySide6.QtCore import QUrl
from PySide6.QtQuick import QQuickView
from PySide6.QtGui import QGuiApplication

import qmlshader_rc  # 导入编译后的资源模块

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    view = QQuickView()
    view.setSource(QUrl("main.qml"))
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    view.show()
    sys.exit(app.exec())