from PyQt5.QtCore import QAbstractListModel, Qt, pyqtSignal, pyqtSlot, QModelIndex


class PersonModel(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    NumberRole = Qt.UserRole + 2

    personChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.persons = [
            {'name': 'jon', 'number': 2084753},
            {'name': 'jane', 'number': 247504375},
            {'name': 'mike', 'number': 24568095},
        ]

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == PersonModel.NameRole:
            return self.persons[row]["name"]
        if role == PersonModel.NumberRole:
            return self.persons[row]["number"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.persons)

    def roleNames(self):
        return {
            PersonModel.NameRole: b'name',
            PersonModel.NumberRole: b'number'
        }

    @pyqtSlot(str, str)
    def addPerson(self, name, number):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.persons.append({'name': name, 'number': number})
        self.endInsertRows()

    @pyqtSlot(int, str, int)
    def editPerson(self, row, name, number):
        ix = self.index(row, 0)
        self.persons[row] = {'name': name, 'number': number}
        self.dataChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deletePerson(self, row):
        self.beginRemoveRows(QModelIndex(), row, row)
        del self.persons[row]
        self.endRemoveRows()

    @pyqtSlot()
    def deleteAllPersons(self):
        self.beginRemoveRows(QModelIndex(), 0, self.rowCount())
        self.persons = []
        self.endRemoveRows()
