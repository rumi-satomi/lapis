import QtQuick
import QtQuick.Layouts

import "../singletons/"

RowLayout {
	spacing: Theme.spacing

	Workspaces {
		Layout.fillWidth: true
		Layout.fillHeight: true
		Layout.minimumWidth: 100
	}

	Item {
		Layout.fillWidth: true
	}

	SettingsButton {}

	Battery {}

	Clock {}
}
