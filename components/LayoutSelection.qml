import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

import "common"

ComboBox {
  id: container
  property int fontSize: root.font.pointSize * 0.875
  property int screenPadding: parent.Layout.margins
  background: null

  indicator: Button {
    anchors.fill: parent
    Text {
      id: button
      anchors.centerIn: parent

      renderType: Text.QtRendering
      text: keyboard.layouts[keyboard.currentLayout].shortName
      font.family: iconFont
      color: container.focus ? root.theme.accent : root.theme.primary
      font.pointSize: fontSize * 1.5
    }

    background: Rectangle {
      color: "transparent"
    }

    onPressed: {
      container.popup.open()
    }

  }

  model: keyboard.layouts
  onActivated: keyboard.currentLayout = highlightedIndex

  delegate: ItemDelegate {
    id: keyboard_layout
    highlighted: keyboard.currentLayout == index

    implicitHeight: fontSize * 3
    implicitWidth: label.width
    Layout.fillWidth: true

    Text {
      id: label
      leftPadding: 10
      rightPadding: 10
      anchors.verticalCenter: keyboard_layout.verticalCenter

      renderType: Text.QtRendering
      text: modelData.longName
      font.pointSize: fontSize
      color: root.theme.foreground
    }

    background: Rectangle {
      color: "transparent"
    }

    states: [
      State {
        name: "selected"
        when: keyboard_layout.highlighted
        PropertyChanges {
          target: keyboard_layout.background
          color: root.theme.accent
        }
      },
      State {
        name: "highlighted"
        when: index === container.highlightedIndex
        PropertyChanges {
          target: keyboard_layout.background
          color: "#777777"
          opacity: 0.4
        }
      }
    ]

  }

  popup: PopupPanel {
    y: -(height + screenPadding)
    x: (parent.width - width) * 0.5

    model: container.delegateModel
  }
}