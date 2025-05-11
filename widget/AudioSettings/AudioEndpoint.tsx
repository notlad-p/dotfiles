import { bind, Variable } from "astal";
import { App, Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";
import { AudioSettingsWindowName } from "./AudioSettings";
import getVolumeIcon from "../../utils/volume-icon";

type AudioEndpointProps = {
  end: Wp.Endpoint;
  monitorName: string | null;
  isInput?: boolean;
};

const AudioEndpoint = ({
  end,
  monitorName,
  isInput = false,
}: AudioEndpointProps) => {
  const wp = Wp.get_default().audio;
  const isMute = bind(end, "mute");
  const volume = bind(end, "volume");

  const volumeIcon = Variable.derive([isMute, volume], (isMuted, volumeVal) => {
    return getVolumeIcon(isInput, isMuted, volumeVal);
  });

  const expanded = Variable(false);

  // set `expanded` to false when audio widget closed (screen specific)
  const toggled = App.connect("window-toggled", (_source, window) => {
    if (
      monitorName &&
      window.name === `${AudioSettingsWindowName}-${monitorName}` &&
      expanded.get()
    ) {
      expanded.set(false);
    }
  });

  return (
    <box
      vertical
      onDestroy={() => {
        expanded.set(false);
      }}
    >
      <box
        hexpand={false}
        cssClasses={bind(expanded).as((ex) => [
          ex ? "bg-black-700" : "bg-black-800",
          ex ? "hover:bg-black-600" : "hover:bg-black-700",
          "transition",
          "rounded-lg",
        ])}
      >
        <box>
          <button
            hexpand
            onClicked={() => {
              end.set_is_default(true);
            }}
            cssClasses={["p-2", "font-bold", "rounded-md"]}
          >
            <box>
              <image
                iconName={bind(end, "isDefault").as((isDefault) => {
                  if (isInput) {
                    return isDefault ? "headset-mic-blue" : "headset-mic";
                  }

                  return isDefault
                    ? "speaker-headphones-blue-symbolic"
                    : "speaker-headphones-symbolic";
                })}
                cssClasses={["icon-lg", "mr-2"]}
              />

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
            </box>
          </button>
        </box>

        <button
          hexpand={false}
          vexpand
          cssClasses={[
            "p-2",
            "transition",
            "duration-250",
            "hover:bg-black-500",
            "font-bold",
            "rounded-md",
          ]}
          onClicked={() => {
            if (expanded.get()) {
              expanded.set(false);
            } else {
              expanded.set(true);
            }
          }}
        >
          <image
            iconName="caret-small-down"
            cssClasses={expanded((isExpanded) => [
              isExpanded ? "-rotate-180" : "",
              "transition",
            ])}
          />
        </button>
      </box>

      <revealer
        revealChild={bind(expanded)}
        transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        transitionDuration={150}
      >
        <box
          vertical
          cssClasses={["bg-black-700", "rounded-lg", "mt-1", "p-2"]}
        >
          <box vexpand={false}>
            <button
              hexpand={false}
              vexpand={false}
              halign={Gtk.Align.CENTER}
              valign={Gtk.Align.CENTER}
              cssClasses={["hover:bg-black-500", "mr-1", "p-2"]}
              onClicked={() => {
                end.set_mute(!end.mute);
                console.log(end.mute);
              }}
            >
              <image iconName={bind(volumeIcon)} cssClasses={["icon-lg"]} />
            </button>

            <slider
              cssClasses={bind(end, "mute").as((isMuted) => [
                isMuted ? "slider-muted" : "",
              ])}
              vexpand={false}
              hexpand
              heightRequest={8}
              min={0}
              max={150}
              value={Math.round(end.volume * 100)}
              drawValue
              digits={0}
              valuePos={Gtk.PositionType.RIGHT}
              setup={(slide) => {
                slide.add_mark(100, null, null);
                slide.set_format_value_func((_scale, val) => `${val}%`);
              }}
              // TODO: add scroll
              // onScroll
              onChangeValue={(slide) => {
                console.log(slide.value);
                end.set_volume(slide.value / 100);
              }}
            />

            {/* TODO: implement playing sound through output (to test sound output) */}
            {/* <button */}
            {/*   hexpand={false} */}
            {/*   vexpand={false} */}
            {/*   valign={Gtk.Align.CENTER} */}
            {/*   cssClasses={[ */}
            {/*     "bg-black-500", */}
            {/*     "rounded-md", */}
            {/*     "ml-3", */}
            {/*     "p-1.5", */}
            {/*     "hover:bg-black-400", */}
            {/*     "transition", */}
            {/*   ]} */}
            {/* > */}
            {/*   <box */}
            {/*     halign={Gtk.Align.CENTER} */}
            {/*     valign={Gtk.Align.CENTER} */}
            {/*     cssClasses={[]} */}
            {/*   > */}
            {/*     <image iconName="play-symbolic" cssClasses={["icon-base"]} /> */}
            {/*   </box> */}
            {/* </button> */}
          </box>
        </box>
      </revealer>
    </box>
  );
};

export default AudioEndpoint;
