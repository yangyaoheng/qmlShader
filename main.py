import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl

def main():
    app = QGuiApplication(sys.argv)
    
    # 启用QML调试（可选）
    from PySide6.QtQml import QQmlDebuggingEnabler
    QQmlDebuggingEnabler.enableDebugging(True)

    engine = QQmlApplicationEngine()
    
    # 加载主QML文件
    engine.load(QUrl.fromLocalFile("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)
    
    sys.exit(app.exec())

if __name__ == "__main__":
    main()