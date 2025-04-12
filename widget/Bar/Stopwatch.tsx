import { Gtk } from "astal/gtk4";
import { bind } from "astal";

import {
  isStarted,
  secondsEllapsed,
  formatTimerString,
  toggle,
} from "./stopwatch-utils";

const Stopwatch = () => {
  return (
    <box cssClasses={["container"]} spacing={8}>
      <button
        vexpand={false}
        hexpand={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        onClicked={toggle}
      >
        <image
          iconName={bind(isStarted).as((started) =>
            started ? "pause-symbolic" : "play-symbolic",
          )}
        />
      </button>

      <label
        cssClasses={["min-w-64"]}
        label={bind(secondsEllapsed).as((sec) =>
          sec > 0 ? formatTimerString(sec) : "00:00:00",
        )}
      />

      <button
        vexpand={false}
        hexpand={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        onClicked={() => {
          // reset secondsEllapsed to 0
          secondsEllapsed.set(0);
        }}
      >
        <image iconName="reset-timer-symbolic" />
      </button>
    </box>
  );
};

export default Stopwatch;
