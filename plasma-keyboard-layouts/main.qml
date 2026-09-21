// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Components
import QtQuick.Layouts

KeyboardLayout {
    inputMode: InputEngine.InputMode.Latin
    keyWeight: 160
    readonly property real normalKeyWidth: normalKey.width
    readonly property real functionKeyWidth: mapFromItem(normalKey, normalKey.width / 2, 0).x
    KeyboardRow {
        Key {
            key: Qt.Key_Escape
            displayText: "Esc"
            functionKey: true
        }
        Key {
            id: normalKey
            key: Qt.Key_Q
            text: "q"
            alternativeKeys: "q1!"
            smallText: "1"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_W
            text: "w"
            alternativeKeys: "w2@"
            smallText: "2"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_E
            text: "e"
            alternativeKeys: "êe3#ëèé"
            smallText: "3"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_R
            text: "r"
            alternativeKeys: "ŕr4$ř"
            smallText: "4"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_T
            text: "t"
            alternativeKeys: "ţt5%ŧť"
            smallText: "5"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_Y
            text: "y"
            alternativeKeys: "ÿy6^ýŷ"
            smallText: "6"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_U
            text: "u"
            alternativeKeys: "űūũûüu7&ùú"
            smallText: "7"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_I
            text: "i"
            alternativeKeys: "îïīĩi8*ìí"
            smallText: "8"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_O
            text: "o"
            alternativeKeys: "œøõôöòóo9("
            smallText: "9"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_P
            text: "p"
            alternativeKeys: "p0)"
            smallText: "0"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_Minus
            text: "-"
            alternativeKeys: "_=+"
            smallText: "_=+"
            smallTextVisible: true
        }
        BackspaceKey {
            weight: functionKeyWidth
            Layout.fillWidth: false
        }
    }
    KeyboardRow {
        Key {
            key: Qt.Key_Tab
            displayText: "Tab"
            functionKey: true
        }
        Key {
            key: Qt.Key_A
            text: "a"
            alternativeKeys: "aäåãâàá"
        }
        Key {
            key: Qt.Key_S
            text: "s"
            alternativeKeys: "šsşś"
        }
        Key {
            key: Qt.Key_D
            text: "d"
            alternativeKeys: "dđď"
        }
        Key {
            key: Qt.Key_F
            text: "f"
        }
        Key {
            key: Qt.Key_G
            text: "g"
            alternativeKeys: "ġgģĝğ"
        }
        Key {
            key: Qt.Key_H
            text: "h"
        }
        Key {
            key: Qt.Key_J
            text: "j"
        }
        Key {
            key: Qt.Key_K
            text: "k"
        }
        Key {
            key: Qt.Key_L
            text: "l"
            alternativeKeys: "ĺŀłļľl"
        }
        Key {
            key: Qt.Key_Semicolon
            text: ";"
            alternativeKeys: ":[]"
            smallText: ":[]"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_Apostrophe
            text: "'"
            alternativeKeys: "\"{}"
            smallText: "\"{}"
            smallTextVisible: true
        }
        EnterKey {
            weight: functionKeyWidth
            Layout.fillWidth: false
        }
    }
    KeyboardRow {
        ShiftKey {
            weight: functionKeyWidth
            Layout.fillWidth: false
        }
        Key {
            key: Qt.Key_Z
            text: "z"
            alternativeKeys: "zžż"
        }
        Key {
            key: Qt.Key_X
            text: "x"
        }
        Key {
            key: Qt.Key_C
            text: "c"
            alternativeKeys: "çcċčć"
        }
        Key {
            key: Qt.Key_V
            text: "v"
        }
        Key {
            key: Qt.Key_B
            text: "b"
        }
        Key {
            key: Qt.Key_N
            text: "n"
            alternativeKeys: "ņńnň"
        }
        Key {
            key: Qt.Key_M
            text: "m"
        }
        Key {
            key: Qt.Key_Comma
            text: ","
            alternativeKeys: "<"
            smallText: "<"
            smallTextVisible: true
            highlighted: true
        }
        Key {
            key: Qt.Key_Period
            text: "."
            alternativeKeys: ">"
            smallText: ">"
            smallTextVisible: true
            highlighted: true
        }
        Key {
            key: Qt.Key_Slash
            text: "/"
            alternativeKeys: "?"
            smallText: "?"
            smallTextVisible: true
        }
        Key {
            key: Qt.Key_Up
            displayText: "↑"
            functionKey: true
        }
        Key {
            key: Qt.Key_Backslash
            text: "\\"
            alternativeKeys: "|`~"
            smallText: "|`~"
            smallTextVisible: true
        }
    }
    KeyboardRow {
        SymbolModeKey {
            weight: functionKeyWidth
            Layout.fillWidth: false
        }
        ChangeLanguageKey {
            weight: normalKeyWidth
            Layout.fillWidth: false
        }
        SpaceKey {
        }
        HideKeyboardKey {
            weight: normalKeyWidth
            Layout.fillWidth: false
        }
        Key {
            key: Qt.Key_Left
            displayText: "←"
            functionKey: true
            weight: normalKeyWidth
            Layout.fillWidth: false
        }
        Key {
            key: Qt.Key_Down
            displayText: "↓"
            functionKey: true
            weight: normalKeyWidth
            Layout.fillWidth: false
        }
        Key {
            key: Qt.Key_Right
            displayText: "→"
            functionKey: true
            weight: normalKeyWidth
            Layout.fillWidth: false
        }
    }
}
