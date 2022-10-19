import contact_model
import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtQuick import QQuickView
from PyQt5.QtWidgets import QApplication


class MainWindow(QQuickView):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.model = contact_model.PersonModel()
        self.rootContext().setContextProperty('PersonModel', self.model)
        self.rootContext().setContextProperty('MainWindow', self)
        self.setSource(QUrl('ContactModel.qml'))


myApp = QApplication(sys.argv)
ui = MainWindow()
ui.show()
sys.exit(myApp.exec_())
