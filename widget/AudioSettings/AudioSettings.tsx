import { bind, subprocess } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";

import AudioEndpoint from "./AudioEndpoint";

export const AudioSettingsWindowName = "audioSettings";

const AudioSettings = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();
  const wp = Wp.get_default()?.audio;

  const defaultSpeakerMuted = bind(wp.defaultSpeaker, "mute");
  const defaultMicMuted = bind(wp.defaultMicrophone, "mute");

  return (
    <window
      namespace="astal-widget-audio-settings"
      layer={Astal.Layer.TOP}
      marginTop={52}
      marginRight={8}
      name={`${AudioSettingsWindowName}-${monitorName}`}
      cssClasses={[
        "audio-settings-window",
        "bg-black-900",
        "rounded-lg",
        "text-white-500",
        "p-4",
        "min-w-sm",
      ]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | RIGHT}
      application={App}
      defaultWidth={10}
      defaultHeight={10}
      overflow={Gtk.Overflow.HIDDEN}
    >
      <box vertical>
        {wp ? (
          <>
            <box cssClasses={["pb-3"]}>
              <box spacing={6}>
                <button
                  onClicked={() => {
                    wp.defaultSpeaker.mute = !wp.defaultSpeaker.mute;
                    console.log(wp.defaultSpeaker.mute);
                  }}
                  cssClasses={defaultSpeakerMuted.as((isMuted) => [
                    isMuted ? "hover:bg-black-600" : "hover:bg-blue-600",
                    isMuted ? "bg-black-700" : "bg-blue-500",
                    "transition",
                    "duration-200",
                    "p-2",
                  ])}
                >
                  <image
                    iconName={defaultSpeakerMuted.as((isMuted) =>
                      isMuted ? "volume-mute-red" : "volume-high-black",
                    )}
                    cssClasses={["icon-md"]}
                  />
                </button>
                <button
                  onClicked={() => {
                    wp.defaultMicrophone.mute = !wp.defaultMicrophone.mute;
                    console.log(wp.defaultSpeaker.mute);
                  }}
                  cssClasses={defaultMicMuted.as((isMuted) => [
                    isMuted ? "hover:bg-black-600" : "hover:bg-blue-600",
                    isMuted ? "bg-black-700" : "bg-blue-500",
                    "transition",
                    "duration-200",
                    "p-2",
                  ])}
                >
                  <image
                    cssClasses={["icon-md"]}
                    iconName={defaultMicMuted.as((isMuted) =>
                      isMuted ? "microphone-mute-red" : "microphone-high-black",
                    )}
                  />
                </button>
              </box>

              <button
                hexpand
                halign={Gtk.Align.END}
                cssClasses={["p-2", "bg-black-700", "hover:bg-black-600"]}
                onClicked={() => {
                  subprocess("/usr/bin/pavucontrol");
                }}
              >
                <image iconName="settings-cog" cssClasses={["icon-md"]} />
              </button>
            </box>

            <box vertical spacing={8}>
              <box vertical cssClasses={["bg-black-800", "p-3", "rounded-lg"]}>
                <label
                  halign={Gtk.Align.START}
                  label="Output Devices"
                  cssClasses={["font-bold", "pb-2"]}
                />

                <box vertical hexpand={false} spacing={4}>
                  {bind(wp, "speakers").as((endpoints) =>
                    endpoints
                      .sort((a, b) =>
                        a.description.localeCompare(b.description),
                      )
                      .map((end) => (
                        <AudioEndpoint end={end} monitorName={monitorName} />
                      )),
                  )}
                </box>
              </box>

              <box vertical cssClasses={["bg-black-800", "p-3", "rounded-lg"]}>
                <label
                  halign={Gtk.Align.START}
                  label="Input Devices"
                  cssClasses={["font-bold", "pb-2"]}
                />

                <box vertical hexpand={false} spacing={4}>
                  {bind(wp, "microphones").as((endpoints) =>
                    endpoints
                      .sort((a, b) =>
                        a.description.localeCompare(b.description),
                      )
                      .map((end) => (
                        <AudioEndpoint
                          end={end}
                          isInput
                          monitorName={monitorName}
                        />
                      )),
                  )}
                </box>
              </box>
            </box>
          </>
        ) : (
          <label label="Wireplumber object is null" />
        )}
      </box>
    </window>
  );
};

export default AudioSettings;
