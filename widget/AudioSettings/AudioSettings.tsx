import { bind, timeout, Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";

export const AudioSettingsWindowName = "audioSettings";

type AudioEndpointProps = {
  end: Wp.Endpoint;
};

// TODO:
// - Remove big mute toggle button & align others to end
// - Volume icon button next to slider: Account for volume states: mute, zero, low, medium, high, & overamplified

const AudioEndpoint = ({ end }: AudioEndpointProps) => {
  const wp = Wp.get_default().audio;
  const expanded = Variable(true);

  return (
    <box vertical>
      <box
        hexpand={false}
        cssClasses={bind(expanded).as((ex) => [
          ex ? "bg-black-800" : "bg-black-900",
          ex ? "hover:bg-black-700" : "hover:bg-black-800",
          "transition",
          "rounded-lg",
        ])}
      >
        <box hexpand={false}>
          <button
            onClicked={() => {
              end.set_is_default(true);
            }}
            cssClasses={[
              "mr-2",
              "p-2",
              "transition",
              "duration-250",
              "hover:bg-black-600",
              "text-3xl",
              "font-bold",
              "rounded-md",
            ]}
          >
            {/* <label label="HS" /> */}
            <image
              iconName={bind(end, "isDefault").as((isDefault) =>
                isDefault
                  ? "speaker-headphones-blue-symbolic"
                  : "speaker-headphones-symbolic",
              )}
              cssClasses={["icon-lg"]}
            />
          </button>
        </box>

        <button
          hexpand
          vexpand
          cssClasses={["rounded-none", "pr-3"]}
          onClicked={() => {
            if (expanded.get()) {
              expanded.set(false);
            } else {
              expanded.set(true);
            }
          }}
        >
          <label
            label={bind(end, "description").as((description) => {
              const device = wp.devices.find((dev) =>
                description.includes(dev.description),
              );
              if (device) {
                return device.description;
              }

              return `${end.description.length > 30 ? end.description.slice(0, 30) + "..." : end.description}`;
            })}
            halign={Gtk.Align.START}
            cssClasses={bind(end, "isDefault").as((isDefault) => [
              "font-medium",
              isDefault ? "text-blue-500" : "",
            ])}
          />
        </button>
      </box>
      <revealer
        // setup={(self) => timeout(1000, () => (self.revealChild = true))}
        revealChild={bind(expanded)}
        transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        transitionDuration={150}
      >
        <box
          vertical
          cssClasses={["bg-black-800", "rounded-lg", "mt-1", "p-2"]}
        >
          <box vexpand={false}>
            <label label="M" />
            <slider
              vexpand={false}
              hexpand
              heightRequest={8}
              min={0}
              max={150}
              value={Math.round(end.volume * 100)}
              drawValue
              digits={0}
              valuePos={Gtk.PositionType.RIGHT}
              // widthRequest={300}
              setup={(slide) => {
                slide.add_mark(100, null, null);
                slide.set_format_value_func((scale, val) => `${val}%`);
              }}
              // TODO: add scroll
              // onScroll
              onChangeValue={(slide) => {
                console.log(slide.value);
                end.set_volume(slide.value / 100);
              }}
            />
          </box>

          <box spacing={4} cssClasses={["mt-2"]} >
            <button  hexpand cssClasses={["bg-blue-500", "rounded-md", "py-1"]}>
              <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
                <image
                  iconName="volume-mute-black-symbolic"
                  cssClasses={["icon-md", "mr-2"]}
                />
                <label
                  label="Default"
                  cssClasses={["text-black-900", "font-medium"]}
                />
              </box>
            </button>

            <button hexpand cssClasses={["bg-blue-500", "rounded-md", "py-1"]}>
              <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
                <image
                  iconName="volume-mute-black-symbolic"
                  cssClasses={["icon-md", "mr-2"]}
                />
                <label
                  label="Mute"
                  cssClasses={["text-black-900", "font-medium"]}
                />
              </box>
            </button>

            <button hexpand={false} cssClasses={["bg-black-500", "rounded-md", "p-2"]}>
              <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
                <image
                  iconName="play-symbolic"
                  cssClasses={["icon-md"]}
                />
              </box>
            </button>
          </box>
        </box>
      </revealer>
    </box>
  );
};

const AudioSettings = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();
  const wp = Wp.get_default().audio;

  // get devices
  // map endpoints:
  // - If endpoint description contains device name, use device name

  // get devices and display:
  // Description
  // Icon
  // Profile select?
  // get endpoints with same name + profile as description
  // - Display & Modify endpoint stuff: Volume, Mute, Default

  // maybe:
  // - RENAME devices!
  // - display HDMI / TV icon?

  return (
    <window
      // visible={false}
      visible
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
        <box halign={Gtk.Align.START}>
          <label label="Output Devices" cssClasses={["font-bold", "pb-2"]} />
        </box>

        <box vertical hexpand={false} spacing={4}>
          {bind(wp, "speakers").as((endpoints) =>
            endpoints.map((end) => <AudioEndpoint end={end} />),
          )}
        </box>
      </box>
    </window>
  );
};

export default AudioSettings;
