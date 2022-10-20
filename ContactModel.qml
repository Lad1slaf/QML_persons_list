import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.2


Rectangle {
    id: root
    width: 500
    height: 300


    Rectangle {
        id: list_rect
        width: 250
        height: 260



        Image {
            anchors.fill: parent
            source: "./background.png"
            fillMode: Image.PreserveAspectCrop
        }



        Component {
            id: contactDelegate

            Item {
                width: 240
                height: 40

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        list_view.focus = true
                        list_view.currentIndex = index
                }
            }

                Column {
                    Text { text: '<b>Name:</b> ' + name }
                    Text { text: '<b>Number:</b> ' + number }
                }

            Rectangle{
                width: 28
                height: 33
                anchors.right: parent.right

                Image {
                    anchors.fill: parent
                    source: "./button.png"
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            PersonModel.deletePerson(index)
                        }

                    }
                }
            }

            }
        }

        ListView {
            id: list_view
            anchors.fill: parent
            anchors.topMargin: 5
            model: PersonModel
            delegate: contactDelegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }



            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn
            }


        }


    Rectangle{
        width: 250
        height: 40
        anchors.top: list_rect.bottom


        Button {
            width: 97
            height: 40
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.leftMargin: 10
            text: "Add Luis)"
            focusPolicy: Qt.NoFocus
            highlighted : true
            onClicked: {
                PersonModel.addPerson("luis", 22984675948)

            }
        }


        Button {
            width: 150
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            text: "Delete All"
            highlighted : true
            focusPolicy: Qt.NoFocus
            onClicked: {
                PersonModel.deleteAllPersons()
            }
        }

        }

    }


    Rectangle{
        id: add_rect
        width: 250
        height: 150
        anchors.left: list_rect.right

        Image {
            anchors.fill: parent
            source: "./background.png"
            fillMode: Image.PreserveAspectCrop
        }

        TextField {
            id: text_name
            width: 200
            height: 40
            anchors.top: parent.top
            anchors.left: parent.left
            placeholderText: qsTr("Enter name")
            anchors.leftMargin: 25
            anchors.topMargin: 10
            color: "white"
            placeholderTextColor: "blue"
            background: Rectangle {
                id: name_back
                width: 200
                height: 40
                color: text_name.activeFocus ? "green" : "grey"
            }




        }
        TextField {
            id: text_number
            width: 200
            height: 40
            anchors.left: parent.left
            placeholderText: qsTr("Enter number")
            placeholderTextColor: "blue"
            anchors.top: text_name.bottom
            anchors.leftMargin: 25
            anchors.topMargin: 10
            color: "white"
            background: Rectangle {
                id: number_back
                width: 200
                height: 40
                color: text_number.activeFocus ? "green" : "grey"
            }

            validator: RegExpValidator {
                regExp: /\d{8,11}/
            }
        }

        Button {
            width: 150
            height: 40
            text: "Add Person"
            highlighted : true
            focusPolicy: Qt.NoFocus
            anchors.top: text_number.bottom
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.topMargin: 10

            Timer {
                id: timer
                interval: 1500
                running: false
                onTriggered: {
                    number_back.color = Qt.binding(function() { return text_number.activeFocus ? "green" : "grey" })
                    name_back.color = Qt.binding(function() { return text_name.activeFocus ? "green" : "grey" })
                }
            }

            onClicked: {
                if (text_name.length < 2 || text_number.length < 8){
                    number_back.color = "red"
                    name_back.color = "red"
                    timer.start()
                }

                else {
                    PersonModel.addPerson(text_name.text, text_number.text)
                    text_number.remove(0, text_number.length)
                    text_name.remove(0, text_name.length)
                }

            }
        }

    }


    Rectangle{
        id: edit_rect
        width: 250
        height: 150
        anchors.left: list_rect.right
        anchors.top: add_rect.bottom

        Image {
            anchors.fill: parent
            source: "./background.png"
            fillMode: Image.PreserveAspectCrop
        }

        TextField {
            id: edit_name
            width: 200
            height: 40
            anchors.top: parent.top
            anchors.left: parent.left
            placeholderText: qsTr("Enter name")
            anchors.leftMargin: 25
            anchors.topMargin: 10
            color: "white"
            placeholderTextColor: "blue"
            text: PersonModel.getName(list_view.currentIndex)

            background: Rectangle {
                id: edit_name_back
                width: 200
                height: 40
                color: edit_name.activeFocus ? "green" : "grey"
            }


        }
        TextField {
            id: edit_number
            width: 200
            height: 40
            anchors.left: parent.left
            placeholderText: qsTr("Enter number")
            placeholderTextColor: "blue"
            anchors.top: edit_name.bottom
            anchors.leftMargin: 25
            anchors.topMargin: 10
            color: "white"
            text: PersonModel.getNumber(list_view.currentIndex)

             background: Rectangle {
                id: edit_number_back
                width: 200
                height: 40
                color: edit_number.activeFocus ? "green" : "grey"
            }

            validator: RegExpValidator {
                regExp: /\d{8,11}/
            }
        }

        Button {
            width: 150
            height: 40
            text: "Edit Person"
            highlighted : true
            focusPolicy: Qt.NoFocus
            anchors.top: edit_number.bottom
            anchors.left: parent.left
            anchors.leftMargin: 48
            anchors.topMargin: 10

            Timer {
                id: edit_timer
                interval: 1500
                running: false
                onTriggered: {
                    edit_number_back.color = Qt.binding(function() { return edit_number.activeFocus ? "green" : "grey" })
                    edit_name_back.color = Qt.binding(function() { return edit_name.activeFocus ? "green" : "grey" })
                }
            }


            onClicked: {
                if (edit_name.length < 2 || edit_number.length < 8){
                    edit_number_back.color = "red"
                    edit_name_back.color = "red"
                    edit_timer.start()
                }

                else {
                    PersonModel.editPerson(list_view.currentIndex, edit_name.text, edit_number.text)
                    edit_number.remove(0, edit_number.length)
                    edit_name.remove(0, edit_name.length)
                }
            }
        }

    }

}

