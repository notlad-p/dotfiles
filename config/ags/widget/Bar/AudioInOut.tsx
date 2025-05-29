import { bind, Variable } from "astal";
import { App, Gdk, Gtk } from "astal/gtk4";
import { AudioSettingsWindowName } from "../AudioSettings/AudioSettings";
import Wp from "gi://AstalWp";

import getVolumeIcon from "../../utils/volume-icon";

type AudioInOutProps = {
  monitor: Gdk.Monitor;
};
const AudioInOut = ({ monitor }: AudioInOutProps) => {
  const monitorName = monitor.get_connector();

  const wp = Wp.get_default()?.audio;

  const defaultSpeakerMuted = bind(wp.defaultSpeaker, "mute");
  const defaultSpeakerVolume = bind(wp.defaultSpeaker, "volume");
  const speakerIcon = Variable.derive(
    [defaultSpeakerMuted, defaultSpeakerVolume],
    (isMuted, volumeVal) => {
      return getVolumeIcon(false, isMuted, volumeVal);
    },
  );

  const defaultMicMuted = bind(wp.defaultMicrophone, "mute");
  const defaultMicVolume = bind(wp.defaultMicrophone, "volume");
  const micIcon = Variable.derive(
    [defaultMicMuted, defaultMicVolume],
    (isMuted, volumeVal) => {
      return getVolumeIcon(true, isMuted, volumeVal);
    },
  );

  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => {
        // TODO: check if monitor name is null, & send notification
        App.toggle_window(`${AudioSettingsWindowName}-${monitorName}`);
      }}
    >
      <box spacing={10}>
        <image iconName={bind(speakerIcon)} />
        <image iconName={bind(micIcon)} />
      </box>
    </button>
  );
};

export default AudioInOut;
